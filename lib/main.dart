import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notification_center/notification_center.dart';

import 'component/config/app_const.dart';
import 'component/config/app_route.dart';
import 'component/config/app_style.dart';
import 'component/translation/app_translation.dart';
import 'component/util/storage_util.dart';
import 'features/notifications/notifications_controller.dart';
import 'firebase_options.dart';

final logger = Logger(
  level: kDebugMode ? Level.all : Level.warning,
  output: MultiOutput([
    ConsoleOutput(),
  ]),
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  final controller = Get.put(NotificationController());
  await controller.addNotification(
    message.notification?.title ?? 'Tanpa Judul',
    message.notification?.body ?? 'Tidak ada isi',
  );
}

Future<void> initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsiOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsiOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {}
      NotificationCenter().notify('navigate-notification');
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await dotenv.load(fileName: '.env');
  await _dependencyInjection();
  await initializeLocalNotifications();
  if (defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    messaging.getToken().then((value) {
      if (value != null) {
        StorageUtil storage = Get.find();
        storage.setFCMToken(value);
      }
    });

    messaging.onTokenRefresh.listen((fcmToken) {
      StorageUtil storage = Get.find();
      storage.setFCMToken(fcmToken);
    }).onError((err) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      NotificationCenter().notify('navigate-notification');
    });

    final controller = Get.put(NotificationController());

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        await controller.addNotification(
          message.notification?.title ?? 'Tanpa Judul',
          message.notification?.body ?? 'Tidak ada isi',
        );
      }

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'your_channel_id',
              'Your Channel Name',
              channelDescription: 'Your channel description',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  runApp(const AppInitializer());
}

Future _dependencyInjection() async {
  final storage = StorageUtil(SecureStorage());
  Get.lazyPut(() => storage, fenix: true);
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  Future<void> _setOrientation(BuildContext context) async {
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setOrientation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        overlayColor: AppStyle.dialogBgColor,
        child: GetMaterialApp(
          title: AppConst.appName,
          // theme: AppTheme.themeLight,
          theme: AppStyle.themeData(context),
          translations: AppTranslation(),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          supportedLocales: const [Locale('en'), Locale('id')],
          initialRoute: AppRoute.defaultRoute,
          unknownRoute: GetPage(
              name: AppRoute.notFound, page: () => const UnknownRoutePage()),
          getPages: AppRoute.pages,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ));
  }
}

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('No route defined for this page')),
    );
  }
}

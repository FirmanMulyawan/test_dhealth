import 'package:get/get_navigation/src/routes/get_route.dart';

// import '../../features/bottom_nav/binding/bottom_nav_binding.dart';
import '../../features/bottom_nav/presentation/bottom_nav_screen.dart';
import '../../features/dashboard/binding/dashboard_binding.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/login/binding/login_binding.dart';
import '../../features/login/login_screen.dart';

class AppRoute {
  static const String defaultRoute = '/';
  static const String notFound = '/notFound';

  static const String bottomNavHome = '/bottomNavHome';
  static const String dashboard = '/dashboard';

  static List<GetPage> pages = [
    // GetPage(
    //   name: defaultRoute,
    //   page: () => const LoginScreen(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: defaultRoute,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    // GetPage(
    //   name: bottomNavHome,
    //   page: () => const BottomNavScreen(),
    //   binding: BottomNavBinding(),
    // ),
  ];
}

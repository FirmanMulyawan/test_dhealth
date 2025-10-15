import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConst {
  static String appName = "Firman Test";
  static bool isDebuggable = true;
  static String appUrl = dotenv.env['API_LINK']!;
  static String defaultLocale = "id-ID";

  static String path = 'assets/';

  // icon
  static String iconBackButton = '${path}icons/ic_back_button.svg';
  static String iconCategoriesActive = '${path}icons/ic_categories_active.svg';
  static String iconCategoriesInActive =
      '${path}icons/ic_categories_inactive.svg';
  static String iconHomeActive = '${path}icons/ic_home_active.svg';
  static String iconHomeInActive = '${path}icons/ic_home_inactive.svg';
  static String iconNotificationsActive =
      '${path}icons/ic_notifications_active.svg';
  static String iconNotificationsInActive =
      '${path}icons/ic_notifications_inactive.svg';
  static String iconProfileActive = '${path}icons/ic_profile_active.svg';
  static String iconProfileInActive = '${path}icons/ic_profile_inactive.svg';
  static String iconRefresh = '${path}icons/ic_refresh.svg';
  static String iconSearchActive = '${path}icons/ic_search_active.svg';
  static String iconSearchInActive = '${path}icons/ic_search_inactive.svg';

  // images
  static String noInternetIcon = '${path}images/im_no_internet.png';

}

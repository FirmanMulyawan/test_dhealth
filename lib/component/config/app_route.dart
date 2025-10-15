import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/bottom_nav/binding/bottom_nav_binding.dart';
import '../../features/bottom_nav/presentation/bottom_nav_screen.dart';

class AppRoute {
  static const String defaultRoute = '/';
  static const String notFound = '/notFound';

  static const String bottomNavHome = '/bottomNavHome';

  static List<GetPage> pages = [
    GetPage(
      name: defaultRoute,
      page: () => const BottomNavScreen(),
      binding: BottomNavBinding(),
    ),
  ];
}

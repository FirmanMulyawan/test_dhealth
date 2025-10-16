import 'package:get/get.dart';

import '../../../component/util/network.dart';
import '../../categories/presentation/categories_controller.dart';
import '../../categories/repository/categories_datasource.dart';
import '../../categories/repository/categories_repository.dart';
import '../../home/presentation/home_controller.dart';
import '../../home/repository/home_datasource.dart';
import '../../home/repository/home_repository.dart';
import '../../search/presentation/search_controller.dart';
import '../../search/repository/search_datasource.dart';
import '../../search/repository/search_repository.dart';
import '../presentation/bottom_nav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());

    Get.lazyPut(() => HomeDatasource(Network.dioClient()));
    Get.lazyPut(() => HomeRepository(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));

    Get.lazyPut(() => SearchDatasource(Network.dioClient()));
    Get.lazyPut(() => SearchRepository(Get.find()));
    Get.lazyPut(() => SearchEveythingController(Get.find()));

    Get.lazyPut(() => CategoriesDatasource(Network.dioClient()));
    Get.lazyPut(() => CategoriesRepository(Get.find()));
    Get.lazyPut(() => CategoriesController(Get.find()));
  }
}

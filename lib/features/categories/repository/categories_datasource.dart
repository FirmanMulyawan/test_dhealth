import '../../../component/base/base_dio_datasource.dart';
import '../../../component/config/app_const.dart';
import '../../../component/ext/dio_ext.dart';

class CategoriesDatasource extends BaseDioDataSource {
  CategoriesDatasource(super.client);

  Future<String> getCategories(String? category, int page, int size) {
    String path = '/top-headlines';
    // https://newsapi.org/v2/top-headlines?category=technology&page=3&pageSize=10&apiKey

    Map<String, dynamic> data = {
      'category': category,
      'page': page,
      'pageSize': size,
      'apiKey': AppConst.apiKey
    };

    return get<String>(path, queryParameters: data).load();
  }
}

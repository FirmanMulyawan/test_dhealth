import '../../../component/base/base_dio_datasource.dart';
import '../../../component/config/app_const.dart';
import '../../../component/ext/dio_ext.dart';

class HomeDatasource extends BaseDioDataSource {
  HomeDatasource(super.client);

  Future<String> getTopHeadlines(int page, int size) {
    String path = '/top-headlines';

    Map<String, dynamic> data = {
      'country': 'us',
      'page': page,
      'pageSize': size,
      'apiKey': AppConst.apiKey
    };

    return get<String>(path, queryParameters: data).load();
  }
}

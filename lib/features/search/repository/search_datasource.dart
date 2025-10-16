import '../../../component/base/base_dio_datasource.dart';
import '../../../component/config/app_const.dart';
import '../../../component/ext/dio_ext.dart';

class SearchDatasource extends BaseDioDataSource {
  SearchDatasource(super.client);

  Future<String> getEverything(
      String search, String? kategory, int page, int size) {
    String path = '/everything';
    // https://newsapi.org/v2/everything?q=technology&page=1&pageSize=10&apiKey=

    Map<String, dynamic> data = {
      'q': search,
      'page': page,
      'pageSize': size,
      'apiKey': AppConst.apiKey
    };

    if (kategory != null && kategory.isNotEmpty) {
      data['q'] = '$search $kategory';
    }

    return get<String>(path, queryParameters: data).load();
  }
}

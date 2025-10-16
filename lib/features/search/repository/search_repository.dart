import 'package:dio/dio.dart';

import '../../../component/base/base_repository.dart';
import '../../../component/model/response_model.dart';
import '../../../component/util/state.dart';
import '../../../component/model/news_response.dart';
import 'search_datasource.dart';

class SearchRepository extends BaseRepository {
  final SearchDatasource _dataSource;

  SearchRepository(this._dataSource);

  Future<void> getEverything({
    required ResponseHandler<ListResponseModel<Articles>> response,
    required String search,
    String? kategory,
    required int page,
    required int size,
  }) async {
    try {
      final data = await _dataSource
          .getEverything(search, kategory, page, size)
          .then(mapToData)
          .then((value) {
        return ListResponseModel<Articles>.fromJson(
            value,
            (data) => data
                .map((e) => Articles.fromJson(e as Map<String, dynamic>))
                .toList());
      });

      response.onSuccess.call(data);
      response.onDone.call();
    } on DioException catch (e) {
      handleDioException(e, response);
    } catch (e) {
      response.onFailed(0, e.toString());
      response.onDone.call();
    }
  }
}

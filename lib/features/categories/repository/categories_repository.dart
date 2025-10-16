import 'package:dio/dio.dart';

import '../../../component/base/base_repository.dart';
import '../../../component/model/response_model.dart';
import '../../../component/util/state.dart';
import '../../../component/model/news_response.dart';
import 'categories_datasource.dart';

class CategoriesRepository extends BaseRepository {
  final CategoriesDatasource _dataSource;

  CategoriesRepository(this._dataSource);

  Future<void> getTopHeadlines({
    required ResponseHandler<ListResponseModel<Articles>> response,
    required String categories,
    required int page,
    required int size,
  }) async {
    try {
      final data = await _dataSource
          .getCategories(categories, page, size)
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

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../config/app_const.dart';
// import '../model/response_model.dart';
import '../util/helper.dart';
import '../util/state.dart';

class BaseRepository {
  final String _errorMsgHandler = "Failed to load, please try again";

  mapToData(String event) {
    try {
      return jsonDecode(event);
    } catch (e) {
      if (AppConst.isDebuggable) {
        throw Exception(e);
      } else {
        throw Exception(_errorMsgHandler);
      }
    }
  }

  handleDioException(
    DioException e,
    ResponseHandler response,
  ) async {
    if (e.response?.statusCode == 401) {
      if (Get.isDialogOpen == false) {
        await AlertModel.showAlert(
          title: 'sessionExpired'.tr,
          message: 'sessionExpiredDesc'.tr,
        );
      }
    } else if (e.response?.statusCode == 403) {
    } else {
      if (e.response?.data != null) {
        try {
          Map<String, dynamic> valueMap = jsonDecode(e.response?.data);
          // final error = ResponseModel.fromJson(valueMap);
          // response.onFailed(e.response?.statusCode, error.message.toString());
          response.onFailed(e.response?.statusCode, valueMap.toString());
          response.onDone.call();
        } catch (_) {
          response.onFailed(e.response?.statusCode,
              'Failed to load data. Please try again later');
          response.onDone.call();
        }
      } else {
        response.onFailed(e.response?.statusCode,
            'Failed to load data. Please try again later');
        response.onDone.call();
      }
    }
  }
}

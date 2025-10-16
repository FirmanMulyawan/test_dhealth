import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../../../component/model/news_response.dart';
import '../repository/home_repository.dart';

class HomeController extends GetxController {
  final topHeader = <Articles>[].obs;
  final isLoading = false.obs;
  final loadMoreLoading = false.obs;

  int page = 1;
  final int pageSize = 5;
  bool hasMore = true;

  final HomeRepository _repository;
  final ScrollController scrollController = ScrollController();

  HomeController(this._repository);

  @override
  void onInit() {
    getTopHeadlines();
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();

    super.onClose();
  }

  // void getTopHeadlines() {
  //   isLoading = true;
  //   update();
  //   _repository.getTopHeadlines(
  //     response: ResponseHandler(
  //       onSuccess: (data) async {
  //         topHeader.clear();
  //         // if (data.status == "ok") {
  //         topHeader.addAll((data.articles ?? []).cast<Articles>());
  //         // }
  //       },
  //       onFailed: (e, message) {
  //         AlertModel.showAlert(title: "Error", message: message);
  //       },
  //       onDone: () {
  //         isLoading = false;
  //         update();
  //       },
  //     ),
  //   );
  // }

  Future<void> getTopHeadlines({
    bool refresh = false,
  }) async {
    if (isLoading.value) return;

    if (refresh) {
      page = 1;
      hasMore = true;
      topHeader.clear();
    }

    isLoading.value = true;

    _repository.getTopHeadlines(
      page: page,
      size: pageSize,
      response: ResponseHandler(
        onSuccess: (data) async {
          final fetched = data.articles ?? [];
          if (fetched.length < pageSize) {
            hasMore = false;
          }
          topHeader.addAll(fetched);
        },
        onFailed: (e, message) {
          AlertModel.showAlert(title: "Error", message: message);
        },
        onDone: () {
          isLoading.value = false;
        },
      ),
    );
  }

  int getPageNumber(int itemsCount, int pageSize) {
    return (itemsCount / pageSize).ceil().toInt() + 1;
  }

  Future<void> loadMore() async {
    if (loadMoreLoading.value || !hasMore) return;

    loadMoreLoading.value = true;
    page++;

    _repository.getTopHeadlines(
      page: page,
      size: pageSize,
      response: ResponseHandler(
        onSuccess: (data) {
          final fetched = data.articles ?? [];
          if (fetched.length < pageSize) {
            hasMore = false;
          }
          topHeader.addAll(fetched);
        },
        onFailed: (e, message) {
          AlertModel.showAlert(title: "Error", message: message);
        },
        onDone: () {
          loadMoreLoading.value = false;
        },
      ),
    );
  }

  void _onScroll() {
    if (!scrollController.hasClients || loadMoreLoading.value || !hasMore) {
      return;
    }

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      loadMore();
    }
  }
}

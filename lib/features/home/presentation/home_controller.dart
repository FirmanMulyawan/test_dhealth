import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../../../component/model/news_response.dart';
import '../repository/home_repository.dart';

class HomeController extends GetxController {
  final article = <Articles>[].obs;
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

  Future<void> getTopHeadlines({
    bool refresh = false,
  }) async {
    if (isLoading.value) return;

    if (refresh) {
      page = 1;
      hasMore = true;
      article.clear();
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
          article.addAll(fetched);
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
          article.addAll(fetched);
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

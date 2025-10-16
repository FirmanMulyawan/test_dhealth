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
  int pageSize = 5;
  int totalResults = 0;
  final hasMore = true.obs;

  final HomeRepository _repository;
  final ScrollController scrollController = ScrollController();

  HomeController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getTopHeadlines();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();

    super.onClose();
  }

  Future<void> getTopHeadlines({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (loadMoreLoading.value || !hasMore.value) return;

      loadMoreLoading.value = true;
      page++;
    } else {
      isLoading.value = true;
      page = 1;
      hasMore.value = true;
      article.clear();
    }

    await _repository.getTopHeadlines(
      page: page,
      size: pageSize,
      response: ResponseHandler(
        onSuccess: (data) async {
          final fetched = data.articles ?? [];

          if (page == 1 && data.totalResults != null) {
            totalResults = data.totalResults!;
          }

          if (fetched.isNotEmpty) {
            article.addAll(fetched);
          } else {
            hasMore.value = false;
          }

          if (article.length >= totalResults) {
            hasMore.value = false;
          }
        },
        onFailed: (e, message) {
          AlertModel.showAlert(title: "Error", message: message);
        },
        onDone: () {
          isLoading.value = false;
          loadMoreLoading.value = false;
          update();
        },
      ),
    );
  }

  void _onScroll() {
    if (!scrollController.hasClients ||
        loadMoreLoading.value ||
        !hasMore.value) {
      return;
    }

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      getTopHeadlines(isLoadMore: true);
    }
  }

  Future<void> onRefresh() async {
    await getTopHeadlines(isLoadMore: false);
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../component/model/category_model.dart';
import '../../../component/model/news_response.dart';
import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../repository/search_repository.dart';

class SearchEveythingController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final SearchRepository _repository;
  final Debouncer _searchDebouncer =
      Debouncer(delay: Duration(milliseconds: 500));

  int page = 1;
  int pageSize = 5;
  int totalResults = 0;
  final hasMore = true.obs;

  final isLoading = false.obs;
  final loadMoreLoading = false.obs;
  final article = <Articles>[].obs;

  final ScrollController scrollController = ScrollController();

  SearchEveythingController(this._repository);
  final List<CategoryModel> categorys = [
    CategoryModel(id: "general", categoryName: "General"),
    CategoryModel(id: "technology", categoryName: "Technology"),
    CategoryModel(id: "business", categoryName: "Business"),
    CategoryModel(id: "science", categoryName: "Science"),
    CategoryModel(id: "sports", categoryName: "Sports"),
    CategoryModel(id: "health", categoryName: "Health"),
    CategoryModel(id: "entertainment", categoryName: "Entertainment"),
  ];

  final RxString selectedCategoryId = ''.obs;

  String get getCategoryName {
    return categorys
        .firstWhere((e) => e.id == selectedCategoryId.value,
            orElse: () => CategoryModel(id: '', categoryName: 'Pilih Category'))
        .categoryName;
  }

  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();

    super.onClose();
  }

  void changeSelectedCategory(String category) async {
    selectedCategoryId.value = category;
    update();
    await getSearchList(isLoadMore: false);
  }

  void updateKeyword() {
    _searchDebouncer.call(() {
      getSearchList(isLoadMore: false);
    });
  }

  Future<void> getSearchList({
    bool isLoadMore = false,
  }) async {
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

    await _repository.getEverything(
      search: searchController.text,
      kategory: selectedCategoryId.value,
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
      getSearchList(isLoadMore: true);
    }
  }

  Future<void> onRefresh() async {
    await getSearchList(isLoadMore: false);
  }
}

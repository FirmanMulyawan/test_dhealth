import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/model/category_model.dart';
import '../../../component/model/news_response.dart';
import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../repository/categories_repository.dart';

class CategoriesController extends GetxController {
  final article = <Articles>[].obs;
  final isLoading = false.obs;
  final loadMoreLoading = false.obs;

  int page = 1;
  final int pageSize = 5;
  final hasMore = true.obs;
  int totalResults = 0;
  final ScrollController scrollController = ScrollController();
  String selectedCategoryId = '';

  final CategoriesRepository _repository;

  CategoriesController(this._repository);

  final List<CategoryModel> categorys = [
    CategoryModel(id: "general", categoryName: "General"),
    CategoryModel(id: "technology", categoryName: "Technology"),
    CategoryModel(id: "business", categoryName: "Business"),
    CategoryModel(id: "science", categoryName: "Science"),
    CategoryModel(id: "sports", categoryName: "Sports"),
    CategoryModel(id: "health", categoryName: "Health"),
    CategoryModel(id: "entertainment", categoryName: "Entertainment"),
  ];

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
    selectedCategoryId = category;
    update();

    await getCategoriesList(isLoadMore: false);
  }

  Future<void> getCategoriesList({
    bool isLoadMore = false,
  }) async {
    if (isLoading.value) return;

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

    _repository.getTopHeadlines(
      page: page,
      size: pageSize,
      categories: selectedCategoryId,
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
      getCategoriesList(isLoadMore: true);
    }
  }

  Future<void> onRefresh() async {
    await getCategoriesList(isLoadMore: false);
  }
}

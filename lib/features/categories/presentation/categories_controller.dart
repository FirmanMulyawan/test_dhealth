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
  bool hasMore = true;

  final CategoriesRepository _repository;
  final ScrollController scrollController = ScrollController();
  String selectedCategoryId = '';

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

  void changeSelectedCategory(String category) {
    selectedCategoryId = category;
    update();

    getCategoriesList(refresh: true);
  }

  Future<void> getCategoriesList({
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
      categories: selectedCategoryId,
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

  void _onScroll() {
    if (!scrollController.hasClients || loadMoreLoading.value || !hasMore) {
      return;
    }

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      loadMore();
    }
  }

  Future<void> loadMore() async {
    if (loadMoreLoading.value || !hasMore) return;

    loadMoreLoading.value = true;
    page++;

    _repository.getTopHeadlines(
      page: page,
      size: pageSize,
      categories: selectedCategoryId,
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
}

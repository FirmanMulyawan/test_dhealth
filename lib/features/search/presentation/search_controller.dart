import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../repository/search_repository.dart';

class CategoryModel {
  final String id;
  final String categoryName;

  CategoryModel({required this.id, required this.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['category_Name'],
    );
  }
}

class SearchEveythingController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final SearchRepository _repository;
  final Debouncer _searchDebouncer =
      Debouncer(delay: Duration(milliseconds: 500));

  int page = 1;
  final int pageSize = 5;
  bool hasMore = true;

  SearchEveythingController(this._repository);

  final List<CategoryModel> categorys = [
    CategoryModel(id: "technology", categoryName: "Technology"),
    CategoryModel(id: "business", categoryName: "Business"),
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

  void changeSelectedCategory(String category) {
    selectedCategoryId.value = category;
    update();
  }

  void updateKeyword() {
    _searchDebouncer.call(() {
      // getDailyDoa();
    });
  }
}

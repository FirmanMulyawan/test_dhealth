import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../component/config/app_style.dart';
import '../../../component/widget/card_news.dart';
import 'categories_controller.dart';

class CategoriesScreen extends GetView<CategoriesController> {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(bottom: false, child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            _categoryList(),
            SizedBox(
              height: 20,
            ),
            Expanded(child: _listArticle())
          ],
        ));
  }

  Widget _categoryList() {
    return GetBuilder<CategoriesController>(builder: (ctrl) {
      final categorys = ctrl.categorys;

      return Wrap(
        direction: Axis.horizontal,
        spacing: 20,
        runSpacing: 20,
        children: categorys.map((item) {
          final isSelected = ctrl.selectedCategoryId == item.id;

          return GestureDetector(
            onTap: () => ctrl.changeSelectedCategory(item.id),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppStyle.whiteColor,
                border: Border.all(
                  color: isSelected ? AppStyle.blue : AppStyle.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                item.categoryName,
                textAlign: TextAlign.center,
                style: AppStyle.regular(
                  size: 14,
                  textColor: isSelected ? AppStyle.blue : AppStyle.black,
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _listArticle() {
    return Obx(() {
      final isLoading = controller.isLoading.value;
      final isLoadMore = controller.loadMoreLoading.value;
      final article = controller.article;

      if (isLoading && article.isEmpty) {
        return Skeletonizer(
          enabled: true,
          child: ListView.separated(
            itemCount: 5,
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
            itemBuilder: (context, index) {
              return CardNews(isLoading: true, data: null);
            },
          ),
        );
      }

      return ListView.separated(
          itemCount: article.length + (isLoadMore ? 1 : 0),
          controller: controller.scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20,
            );
          },
          itemBuilder: (context, index) {
            if (index == article.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final item = controller.article[index];

            return CardNews(isLoading: false, data: item);
          });
    });
  }
}

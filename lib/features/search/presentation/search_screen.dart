import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../component/config/app_const.dart';
import '../../../component/config/app_style.dart';
import '../../../component/widget/card_news.dart';
import 'search_controller.dart';

class SearchScreen extends GetView<SearchEveythingController> {
  const SearchScreen({super.key});

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
          _searchBar(),
          SizedBox(
            height: 10,
          ),
          _categories(context),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppStyle.blue,
              onRefresh: () {
                controller.getSearchList(refresh: true);
                return Future.value();
              },
              child: _listSearch(),
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      autocorrect: false,
      controller: controller.searchController,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: (value) {
        controller.updateKeyword();
      },
      style: AppStyle.regular(
        size: 20,
      ),
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: AppStyle.regular(
          size: 20,
          textColor: AppStyle.searchHintColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: AppStyle.searchBorderColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: AppStyle.searchBorderColor,
            width: 1.5,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
            minHeight: 24, minWidth: 52, maxHeight: 24, maxWidth: 52),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 18, right: 10),
          child: SvgPicture.asset(
            AppConst.searchIcon,
            colorFilter: ColorFilter.mode(
              AppStyle.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        fillColor: AppStyle.whiteColor,
        filled: true,
      ),
    );
  }

  Widget _categories(context) {
    return GetBuilder<SearchEveythingController>(builder: (ctrl) {
      return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          value: ctrl.selectedCategoryId.value.isEmpty
              ? null
              : ctrl.selectedCategoryId.value,
          items: ctrl.categorys.map((category) {
            return DropdownMenuItem<String>(
              value: category.id,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  category.categoryName,
                  style:
                      AppStyle.bold(textColor: AppStyle.whiteColor, size: 16),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            ctrl.changeSelectedCategory(value!);
          },
          customButton: Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: AppStyle.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  ctrl.getCategoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  AppConst.arrowDown,
                  // width: 7,
                  // height: 10,
                ),
              ],
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppStyle.blue,
            ),
          ),
        ),
      );
    });
  }

  Widget _listSearch() {
    return Obx(() {
      final isLoading = controller.isLoading.value;
      final isLoadMore = controller.loadMoreLoading.value;
      final length = controller.article.length;

      if (isLoading && controller.article.isEmpty) {
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
          itemCount: length + (isLoadMore ? 1 : 0),
          controller: controller.scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20,
            );
          },
          itemBuilder: (context, index) {
            if (index == length) {
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

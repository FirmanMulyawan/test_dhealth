import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../component/config/app_style.dart';
import '../../../component/widget/card_news.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

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
          Text(
            "Top Headline",
            style: AppStyle.bold(size: 30, textColor: AppStyle.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "UNITED STATES",
            style: AppStyle.bold(size: 16, textColor: AppStyle.black),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppStyle.blue,
              onRefresh: () {
                controller.getTopHeadlines(refresh: true);
                return Future.value();
              },
              child: Obx(
                () {
                  final isLoading = controller.isLoading.value;
                  final isLoadMore = controller.loadMoreLoading.value;
                  final length = controller.topHeader.length;

                  if (isLoading && controller.topHeader.isEmpty) {
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.separated(
                        itemCount: 5,
                        controller: controller.scrollController,
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
                    // padding: EdgeInsets.all(0),
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

                      final item = controller.topHeader[index];

                      return CardNews(isLoading: false, data: item);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

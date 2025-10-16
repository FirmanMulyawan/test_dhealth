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
      backgroundColor: Colors.white,
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
          const SizedBox(height: 20),
          Text("Top Headline",
              style: AppStyle.bold(size: 28, textColor: AppStyle.black)),
          const SizedBox(height: 8),
          Text("UNITED STATES",
              style: AppStyle.bold(size: 16, textColor: AppStyle.blue)),
          const SizedBox(height: 12),
          Expanded(
            child: Obx(() {
              final isLoading = controller.isLoading.value;
              final isLoadMore = controller.loadMoreLoading.value;
              final hasMore = controller.hasMore.value;
              final list = controller.article;

              if (isLoading && list.isEmpty) {
                return ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (_, __) => Skeletonizer(
                    enabled: true,
                    child: CardNews(isLoading: true, data: null),
                  ),
                );
              }

              if (list.isEmpty) {
                return const Center(
                  child: Text("Tidak ada berita ditemukan."),
                );
              }

              return RefreshIndicator(
                color: AppStyle.blue,
                onRefresh: controller.onRefresh,
                child: ListView.separated(
                  controller: controller.scrollController,
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: list.length + 1,
                  itemBuilder: (context, index) {
                    if (index < list.length) {
                      final item = list[index];
                      return CardNews(isLoading: false, data: item);
                    } else {
                      if (isLoadMore) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppStyle.blue,
                            ),
                          ),
                        );
                      } else if (!hasMore) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Semua berita sudah ditampilkan",
                            textAlign: TextAlign.center,
                            style: AppStyle.regular(
                              size: 14,
                              textColor: AppStyle.greyDark,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../component/config/app_const.dart';
import '../../../component/config/app_style.dart';
import 'bottom_nav_controller.dart';

class BottomNavScreen extends GetView<BottomNavController> {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: GetBuilder<BottomNavController>(
        builder: (ctrl) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: IndexedStack(
                      index: ctrl.selectedScreen,
                      children: ctrl.screenList,
                    ),
                  ),
                  _navbarItem(context),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _navbarItem(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF101828).withAlpha(26),
            blurRadius: 15,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              _bottomTabs(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomTabs(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (ctrl) {
        return Row(
          children: [
            _bottomTabItem(
              context: context,
              isAvtive: ctrl.selectedScreen == 0,
              title: "Home",
              onTap: () {
                ctrl.setSelectedScreen(0);
              },
              icon: ctrl.selectedScreen == 0
                  ? _iconBottomTab(
                      value: AppConst.iconHomeActive,
                    )
                  : _iconBottomTab(
                      value: AppConst.iconHomeInActive,
                    ),
            ),
            _bottomTabItem(
              context: context,
              isAvtive: ctrl.selectedScreen == 1,
              title: "Search",
              onTap: () {
                ctrl.setSelectedScreen(1);
              },
              icon: ctrl.selectedScreen == 1
                  ? _iconBottomTab(
                      value: AppConst.iconSearchActive,
                    )
                  : _iconBottomTab(
                      value: AppConst.iconSearchInActive,
                    ),
            ),
            _bottomTabItem(
              context: context,
              isAvtive: ctrl.selectedScreen == 2,
              title: "Categories",
              onTap: () {
                ctrl.setSelectedScreen(2);
              },
              icon: ctrl.selectedScreen == 2
                  ? _iconBottomTab(
                      value: AppConst.iconCategoriesActive,
                    )
                  : _iconBottomTab(
                      value: AppConst.iconCategoriesInActive,
                    ),
            ),
            _bottomTabItem(
              context: context,
              isAvtive: ctrl.selectedScreen == 3,
              title: "Notifications",
              onTap: () {
                ctrl.setSelectedScreen(3);
              },
              icon: ctrl.selectedScreen == 3
                  ? _iconBottomTab(
                      value: AppConst.iconNotificationsActive,
                    )
                  : _iconBottomTab(
                      value: AppConst.iconNotificationsInActive,
                    ),
            ),
            _bottomTabItem(
              context: context,
              isAvtive: ctrl.selectedScreen == 4,
              title: "Profile",
              onTap: () {
                ctrl.setSelectedScreen(4);
              },
              icon: ctrl.selectedScreen == 4
                  ? _iconBottomTab(
                      value: AppConst.iconProfileActive,
                    )
                  : _iconBottomTab(
                      value: AppConst.iconProfileInActive,
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _bottomTabItem(
      {void Function()? onTap,
      required Widget icon,
      required BuildContext context,
      required bool isAvtive,
      required String title}) {
    double bottom = MediaQuery.of(context).padding.bottom;
    bottom = bottom > 0 ? bottom : 20;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: bottom),
          child: Column(
            children: [
              icon,
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: AppStyle.medium(
                    size: 12,
                    textColor:
                        isAvtive == true ? AppStyle.blue : AppStyle.greyDark),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconBottomTab({
    String value = "",
  }) {
    return SvgPicture.asset(
      value,
      width: 25,
      height: 25,
    );
  }
}

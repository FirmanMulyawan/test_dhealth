import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart' as sizer;

import '../config/app_style.dart';

class TitleContainer extends StatefulWidget {
  const TitleContainer({
    super.key,
    this.children,
    required this.title,
  });

  final List<Widget>? children;
  final String title;

  @override
  State<TitleContainer> createState() => _TitleContainerState();
}

class _TitleContainerState extends State<TitleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: sizer.Device.screenType == sizer.ScreenType.mobile
          ? EdgeInsets.symmetric(horizontal: 25)
          : EdgeInsets.zero,
      width: sizer.Device.screenType == sizer.ScreenType.mobile ? null : 620,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: AppStyle.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppStyle.pressedGreen,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical:
                  sizer.Device.screenType == sizer.ScreenType.mobile ? 17 : 35,
            ),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: AppStyle.bold(
                size: sizer.Device.screenType == sizer.ScreenType.mobile
                    ? 25
                    : 32,
                textColor: AppStyle.whiteColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.children ?? [],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 25),
      width: null,
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
              color: AppStyle.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 17,
            ),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: AppStyle.bold(
                size: 25,
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

import 'package:flutter/material.dart';

import '../config/app_style.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 4,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.text;

    final textSpan = TextSpan(text: text, style: widget.style);
    final tp = TextPainter(
      text: textSpan,
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 40);

    final isOverflow = tp.didExceedMaxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: widget.style,
          maxLines: _expanded ? null : widget.maxLines,
          overflow: TextOverflow.fade,
        ),
        if (isOverflow)
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(_expanded ? 'See Less' : 'See More...',
                  style: AppStyle.bold(size: 14, textColor: AppStyle.blue)),
            ),
          ),
      ],
    );
  }
}

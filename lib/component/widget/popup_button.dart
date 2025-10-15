import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_style.dart';
import '../util/storage_util.dart';

class PopupButton extends StatefulWidget {
  const PopupButton({
    super.key,
    required this.child,
    required this.size,
    required this.color,
    this.shadowColor,
    this.duration = const Duration(milliseconds: 160),
    this.onPressed,
    this.radius,
    this.width,
    this.border,
    this.borderHorizontal = 0.5,
    this.borderTop = 0,
    this.isPassed,
    this.horizontalPadding,
    this.disabledShadowColor,
    this.disabledColor,
    this.backgroundImage,
  });

  final Widget child;
  final Color color;
  final Color? shadowColor;
  final Color? disabledShadowColor;
  final Color? disabledColor;
  final Duration duration;
  final VoidCallback? onPressed;
  final double? radius;
  final double? width;
  final double size;
  final BoxBorder? border;
  final double? borderHorizontal;
  final double? borderTop;
  final Widget? isPassed;
  final double? horizontalPadding;
  final DecorationImage? backgroundImage;

  @override
  State<PopupButton> createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton> {
  double get buttonDepth => widget.size * 0.2;
  bool _isPressed = false;

  void _onTapDown(_) {
    if (widget.onPressed != null) {
      setState(() {
        _isPressed = true;
      });
    }
  }

  void _onTapUp(_) {
    if (widget.onPressed != null) {
      setState(() {
        _isPressed = false;
      });
      playLocalAsset();
      widget.onPressed?.call();
      // });
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vertPadding = widget.width != null ? 15.0 : widget.size * 0.25;
    var horzPadding = widget.width != null ? 15.0 : widget.size * 0.50;
    final radius = BorderRadius.circular(widget.radius ?? horzPadding * 0.5);

    if (widget.horizontalPadding != null) {
      horzPadding = widget.horizontalPadding!;
    }

    return Container(
      width: widget.width,
      height: widget.width,
      padding: EdgeInsets.only(
        top: _isPressed ? _getOffset() : widget.borderTop ?? 0.0,
        bottom: _isPressed ? 0 : _getOffset(),
        left: widget.borderHorizontal ?? 0.5,
        right: widget.borderHorizontal ?? 0.5,
      ),
      decoration: BoxDecoration(
        color: shadowColor(),
        borderRadius: radius,
        border: _isPressed ? null : widget.border,
      ),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: bgColor(),
                    borderRadius: radius,
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: radius,
                      child: Stack(
                        children: <Widget>[
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: bgColor(),
                              borderRadius: radius,
                            ),
                            child: SizedBox.expand(),
                          ),
                          Transform.translate(
                            offset: Offset(0.0, 0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: bgColor(),
                                borderRadius: radius,
                                image: widget.backgroundImage,
                              ),
                              child: SizedBox.expand(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: vertPadding,
                        horizontal: horzPadding,
                      ),
                      child: Center(
                        child: widget.child,
                      ),
                    ),
                    widget.isPassed ?? SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getOffset() {
    return widget.width != null ? 10 : 6;
  }

  Color bgColor() {
    if (widget.onPressed != null) {
      return widget.color;
    } else {
      return widget.disabledColor ?? AppStyle.buttonDisabledColor;
    }
  }

  Color? shadowColor() {
    if (widget.onPressed != null) {
      return _isPressed ? Colors.transparent : widget.shadowColor;
    } else {
      return widget.disabledShadowColor ?? AppStyle.buttonDisabledShadowColor;
    }
  }

  void playLocalAsset() async {
    StorageUtil storage = Get.find();
    final isMute = await storage.isMute() ?? false;
    if (!isMute) {
      final player = AudioPlayer();
      player.play(AssetSource('sounds/button_submit.mp3'));
    }
  }
}

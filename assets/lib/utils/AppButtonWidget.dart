import 'package:flutter/material.dart';
import 'package:mighty_fitness/extensions/colors.dart';
import 'package:mighty_fitness/extensions/common.dart';
import 'package:mighty_fitness/extensions/constants.dart';
import 'package:mighty_fitness/extensions/decorations.dart';
import 'package:mighty_fitness/extensions/extension_util/string_extensions.dart';
import 'package:mighty_fitness/extensions/text_styles.dart';
import '../extensions/extension_util/bool_extensions.dart';


/// Default App Button
class AppButtonWidget extends StatefulWidget {
  final Function? onTap;
  final String? text;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Color? disabledColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final ShapeBorder? shapeBorder;
  final Widget? child;
  final double? elevation;
  final double? height;
  final bool? enabled;
  final bool? enableScaleAnimation;

  const AppButtonWidget({super.key, 
    this.onTap,
    this.text,
    this.width,
    this.color,
    this.textColor,
    this.padding,
    this.margin,
    this.textStyle,
    this.shapeBorder,
    this.child,
    this.elevation,
    this.enabled,
    this.height,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.enableScaleAnimation,
  });

  @override
  _AppButtonWidgetState createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  AnimationController? _controller;

  @override
  void initState() {
    if (widget.enableScaleAnimation.validate(value: enableAppButtonScaleAnimationGlobal)) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: appButtonScaleAnimationDurationGlobal ?? 50),
        lowerBound: 0.0,
        upperBound: 0.1,
      )..addListener(() {
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      _scale = 1 - _controller!.value;
    }

    if (widget.enableScaleAnimation.validate(value: enableAppButtonScaleAnimationGlobal)) {
      return Listener(
        onPointerDown: (details) {
          _controller?.forward();
        },
        onPointerUp: (details) {
          _controller?.reverse();
        },
        child: Transform.scale(
          scale: _scale,
          child: buildButton(),
        ),
      );
    } else {
      return buildButton();
    }
  }

  Widget buildButton() {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: radius(),
        child: MaterialButton(
          minWidth: widget.width,
          padding: widget.padding ?? dynamicAppButtonPadding(context),
          onPressed: widget.enabled.validate(value: true) ? widget.onTap as void Function()? : null,
          color: widget.color ?? appButtonBackgroundColorGlobal,
          shape: widget.shapeBorder ?? defaultAppButtonShapeBorder,
          elevation: widget.elevation ?? defaultAppButtonElevation,
          animationDuration: const Duration(milliseconds: 300),
          height: widget.height,
          disabledColor: widget.disabledColor,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          splashColor: widget.splashColor,
          child: widget.child ??
              Text(
                widget.text!.validate(),
                style: widget.textStyle ??
                    boldTextStyle(
                      color: widget.textColor ?? Colors.white,
                    ),
              ),
        ),
      ),
    );
  }
}

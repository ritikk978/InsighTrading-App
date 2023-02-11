import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_colors.dart';
import 'z_card.dart';

class ZButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final String text;
  final double? elevation;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final bool isLoading;
  final double? radius;
  final BorderRadius? borderRadius;
  final Color borderRadiusColor;
  final Color loadingIconColor;
  final isDisabled;

  ZButton({
    required this.text,
    required this.onTap,
    this.elevation,
    this.backgroundColor,
    this.margin,
    this.width,
    this.height,
    this.textStyle,
    this.padding,
    this.isLoading = false,
    this.isDisabled = false,
    this.radius,
    this.borderRadius,
    this.borderRadiusColor = Colors.transparent,
    this.loadingIconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: height ?? 48,
      width: width ?? null,
      child: ZCard(
        margin: EdgeInsets.symmetric(),
        padding: padding ?? null,
        elevation: elevation,
        color: isDisabled ? Colors.grey : getColor(context),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        borderRadiusColor: borderRadiusColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading)
              Row(
                children: [Center(child: SpinKitFadingCircle(color: loadingIconColor, size: 18)), SizedBox(width: 3)],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            Text(text, style: textStyle ?? TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (isDisabled) return;
          if (!isLoading) onTap();
        },
      ),
    );
  }

  Color getColor(BuildContext context) {
    Color _color = backgroundColor ?? appColorYellow;
    if (!isLoading) return _color;
    return _color.withOpacity(0.8);
  }
}

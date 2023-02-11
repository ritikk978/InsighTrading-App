// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class ZButtonRaised extends StatelessWidget {
//   final GestureTapCallback onTap;
//   final EdgeInsets? margin;
//   final EdgeInsets? padding;
//   final Color? color;
//   final String text;
//   final double? elevation;
//   final double? width;
//   final double? height;
//   final ShapeBorder? shapeBorder;
//   final bool isUpperCaseText;
//   final TextStyle? textStyle;
//   final bool isLoading;
//   final double? radius;

//   ZButtonRaised(
//       {required this.text,
//       required this.onTap,
//       this.elevation,
//       this.color,
//       this.margin,
//       this.shapeBorder,
//       this.width,
//       this.height,
//       this.isUpperCaseText = false,
//       this.textStyle,
//       this.padding,
//       this.isLoading = false,
//       this.radius});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       height: height ?? 40,
//       width: width ?? null,
//       child: RaisedButton(
//         padding: padding ?? null,
//         shape: shapeBorder ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 5)),
//         elevation: getElevation(),
//         color: getColor(context),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (isLoading) Row(children: [Center(child: SpinKitFadingCircle(color: Colors.white, size: 25)), SizedBox(width: 5)]),
//             Text(isUpperCaseText ? text.toUpperCase() : text, style: textStyle ?? TextStyle(color: Colors.white, fontSize: 14)),
//             if (isLoading) SizedBox(width: 25)
//           ],
//         ),
//         onPressed: () {
//           FocusScope.of(context).requestFocus(new FocusNode());
//           if (!isLoading) onTap();
//         },
//       ),
//     );
//   }

//   Color getColor(BuildContext context) {
//     Color _color = color ?? Colors.blue;
//     if (!isLoading) return _color;
//     return _color.withOpacity(0.5);
//   }

//   double getElevation() {
//     if (isLoading) return 1;
//     return elevation ?? 1;
//   }
// }

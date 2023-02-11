import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZEmptyState extends StatefulWidget {
  final String description;
  final double? bottomHeight;
  final double? height;
  ZEmptyState({
    Key? key,
    this.bottomHeight,
    required this.description,
    this.height,
  }) : super(key: key);

  @override
  _ZEmptyStateState createState() => _ZEmptyStateState();
}

class _ZEmptyStateState extends State<ZEmptyState> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? Get.height * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          Image.asset('assets/images/empty_state.png', width: Get.width * .35),
          SizedBox(height: 10),
          Text(widget.description),
          SizedBox(height: widget.bottomHeight ?? 100)
        ],
      ),
    );
  }
}

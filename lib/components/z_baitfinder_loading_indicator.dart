import 'package:flutter/material.dart';

class BaitFinderLoadingIndicator extends StatefulWidget {
  @override
  _BaitFinderLoadingIndicatorState createState() => _BaitFinderLoadingIndicatorState();
}

class _BaitFinderLoadingIndicatorState extends State<BaitFinderLoadingIndicator> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Tween<double> sizeTween = Tween(begin: 60.0, end: 80.0);
  Animation? animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = sizeTween.animate(CurvedAnimation(parent: animationController!, curve: Curves.easeInOut));
    animationController?.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, val) {
        return Container(
          child: Image.asset('assets/images/transparent_logo.png', fit: BoxFit.cover, height: animation!.value, width: animation!.value),
          alignment: Alignment.center,
          height: 90.0,
          width: 90.0,
        );
      },
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}

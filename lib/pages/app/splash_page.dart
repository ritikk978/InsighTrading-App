import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:insigh/pages/user/signals_page.dart';
import 'package:provider/provider.dart';

import '../../constants/images.dart';
import '../../models_providers/app_provider.dart';
import '../../models_providers/auth_provider.dart';
import '../user/signals_closed_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> _leftToRightAnim;
  late Animation<Offset> _rightToLeftAnim;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _leftToRightAnim = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    _rightToLeftAnim = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    if(Platform.isAndroid){
      InAppUpdate.checkForUpdate().then((value) => {
        if(value.updateAvailability == UpdateAvailability.updateAvailable){
          InAppUpdate.performImmediateUpdate()
        }
      });
    }

    Future.delayed(Duration(seconds: 3)).then((value) async {
      await Provider.of<AuthProvider>(context, listen: false).init();
      Provider.of<AppProvider>(context, listen: false);

    //   await Future.delayed(Duration(milliseconds: 250));
    //   FlutterNativeSplash.remove();
    });
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none, children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
        ),
        Center(
          child: Stack(
            children: [
              Center(child: Image.asset(Images.splash_logo, height: 150.0, fit: BoxFit.scaleDown, width: 250.0)),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 90.0, left : 17),
                        child: SlideTransition(child: Image.asset(Images.leftText_logo, height: 50.0, fit: BoxFit.scaleDown, width: 150.0), position: _leftToRightAnim,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 90.0, right: 15),
                        child: SlideTransition(child: Image.asset(Images.rightText_logo, height: 50.0, fit: BoxFit.scaleDown, width: 150.0,), position: _rightToLeftAnim,),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Made From the ', style: TextStyle(color: Colors.black),),
                    Image.asset(Images.heart, height: 20,),
                    Text('of India', style: TextStyle(color: Colors.black),),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fort_parts/view/home_view/nav_bar_view.dart';
import 'package:fort_parts/view/onboarding_view/onboarding_view.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';

class SplashView extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool isExpaded = false;

class _MyHomePageState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      bool firstRun = await IsFirstRun.isFirstRun();
      Timer(
          const Duration(seconds: 8),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => firstRun ? OnBording() : NavBarView())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Container(
            width: Get.width * .4,
            color: Colors.white,
            child: Center(
                child: Stack(
              children: [
                AnimatedSize(
                    curve: Curves.fastOutSlowIn,
                    onEnd: () {
                      setState(() {
                        isExpaded = true;
                      });
                    },
                    duration: Duration(seconds: 2),
                    alignment: Alignment.center,
                    child: Container(
                        width: Get.width * 2,
                        height: Get.height * 2,
                        child: Image.asset(
                          'images/transitionwipe.png',
                          fit: isExpaded ? BoxFit.fitHeight : BoxFit.none,
                        ))),
                Container(
                    width: isExpaded ? Get.width * .8 : Get.width * .4,
                    height: isExpaded ? Get.height * .7 : Get.height * .2,
                    child: Image.asset('images/logo.png')),
              ],
              alignment: Alignment.center,
            ))),
      ),
    );
  }
}

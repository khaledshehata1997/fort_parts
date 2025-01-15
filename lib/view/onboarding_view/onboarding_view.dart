import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/main.dart';
import 'package:fort_parts/view/auth/sign_in_view.dart';
import 'package:get/get.dart';

import '../home_view/home_view.dart';
import '../home_view/nav_bar_view.dart';



class OnBording extends StatefulWidget {


  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
   List<String> imgList = [
    'images/onboarding1.png',
    'images/onboarding2.png',
    'images/onboarding3.png',
  ];
   List<String> imgList2 = [
    'images/Frame 41038 (1).png',
    'images/Frame 41038 (2).png',
    'images/Frame 41038 (3).png',
  ];

  int _currentIndex = 0;
  PageController _pageController = PageController();
  PageController _pageController2 = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void _onNextButtonPressed() {
    if (_currentIndex < imgList.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.to(SignInView());
    }
    if (_currentIndex < imgList2.length - 1) {
      _pageController2.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.to( SignInView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: Get.height*.1,),
              Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.topRight,
                child: TextButton(onPressed: (){
                  Get.to( SignInView());

                }, child: Text("تخطي",textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 20,color: mainColor,fontWeight: FontWeight.bold))),
              ),
              SizedBox(height: Get.height*.025,),
              Container(
                width: 500,
                height: Get.height*.25,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imgList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width*.7,
                      height: MediaQuery.of(context).size.height*2,
                      child: Image.asset(
                        imgList[index],
                       // fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: Get.height*.0352,),
              Container(
                width: 500,
                height: Get.height*.25,
                child: PageView.builder(
                  controller: _pageController2,
                  itemCount: imgList2.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width*.7,
                      height: MediaQuery.of(context).size.height*2,
                      child: Image.asset(
                        imgList2[index],
                       // fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // Positioned(
          //     top: 60,
          //     left: 0,
          //     right: 0,
          //     child: Column(
          //       children: [
          //         Text("مرحبا!",textDirection: TextDirection.rtl,
          //           style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
          //         // SizedBox(
          //         //   height: Get.height * 0.03,
          //         // ),
          //         Text("نحن سعداء بتواجدك في متجر MYD",textDirection: TextDirection.rtl,
          //             style: TextStyle(fontSize: 20,color: Colors.white)),
          //
          //       ],
          //     )
          // ),
          Positioned(
              bottom: 40,
              left: 250,
              right: 0,
              child: TextButton(onPressed: (){
                _onNextButtonPressed();
              }, child: CircleAvatar(
                backgroundColor: mainColor,
                radius: 25,
                child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),

              )
          ),
          ),
          Positioned(
              bottom: 40,
              left: 0,
              right: 250,
              child: TextButton(onPressed: (){
                _onNextButtonPressed();
              }, child: Text('التالي',style: TextStyle(
                  wordSpacing: 2,
                  fontSize: 16,fontWeight: FontWeight.w600,color: mainColor),)
          ),
          ),
          // Positioned(
          //   bottom: 40,
          //   left: 0,
          //   right: 0,
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: imgList.map((url) {
          //           int index = imgList.indexOf(url);
          //           return Container(
          //             width: 8.0,
          //             height: 8.0,
          //             margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: _currentIndex == index
          //                   ? Colors.white
          //                   : Color.fromRGBO(255, 255, 255, 0.4),
          //             ),
          //           );
          //         }).toList(),
          //       ),
          //     ],
          //   ),
          // ),

        ],
      ),
    );
  }
}


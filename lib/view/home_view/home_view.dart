import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:fort_parts/view/auth/sign_in_view.dart';
import 'package:fort_parts/view/service_name/service_home.dart';
import 'package:get/get.dart';
import 'package:local_storage/local_storage.dart';

import '../../constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topRight,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: Get.width * .2,
                        height: Get.height * .1,
                        child: Image.asset('images/logo.png')),
                    SizedBox(width: 10),
                    Container(
                      width: Get.width * .65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'مرحبا بك , ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                              FutureBuilder(
                                  future: HiveHelper.get(hiveBox: HiveBoxes.user),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          AppNavigator.navigateTo(
                                              type: NavigationType.navigateTo,
                                              widget: SignInView());
                                        },
                                        child: Text(
                                          'تسجيل الدخول',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: mainColor),
                                        ),
                                      );
                                    }
                                    return Row(
                                      children: [
                                        Text(
                                          'خالد !',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        SizedBox(width: 4),
                                        Container(
                                            width: 35,
                                            height: 35,
                                            child: Image.asset(
                                              'icons/bye.png',
                                              fit: BoxFit.fill,
                                            )),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'العنوان : ',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold, color: mainColor),
                              ),
                              Text(
                                '3 شارع التحرير, جده',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600, color: mainColor),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: mainColor,
                                size: 35,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Material(
                  elevation: .5,
                  shadowColor: Colors.grey,
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 20, top: 5),
                      suffixIcon: Icon(
                        Icons.search,
                        color: mainColor,
                      ),
                      hintText: 'إبحث عن خدمة',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(5)
                      // )
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10),
                  width: Get.width,
                  child: Stack(
                    children: [
                      Image.asset(
                        'images/slider.png',
                        fit: BoxFit.fill,
                      ),
                      Positioned(top: 30, right: 20, child: Image.asset('icons/label.png')),
                    ],
                  )),
              SizedBox(
                height: Get.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(ServiceHome());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset('icons/img.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'الكهرباء',
                              style: TextStyle(fontSize: 19, color: Colors.black),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        width: Get.width * .43,
                        height: Get.height * .17,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2)
                            ]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ServiceHome());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset('icons/img_1.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'النجاره',
                              style: TextStyle(fontSize: 19, color: Colors.black),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        width: Get.width * .43,
                        height: Get.height * .17,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2)
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(ServiceHome());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset('icons/img_2.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'السباكه',
                              style: TextStyle(fontSize: 19, color: Colors.black),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        width: Get.width * .43,
                        height: Get.height * .17,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2)
                            ]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ServiceHome());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset('icons/img_3.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'تنظيف المكيفات',
                              style: TextStyle(fontSize: 19, color: Colors.black),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        width: Get.width * .43,
                        height: Get.height * .17,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2)
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

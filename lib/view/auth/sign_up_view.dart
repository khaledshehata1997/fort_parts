import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../constants.dart';
import '../home_view/nav_bar_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 60,),
            Container(
                width:100 ,
                height: 90,
                child: Image.asset('images/logo.png')),
            SizedBox(height: 40,),
            Container(

                margin: EdgeInsets.only(left: Get.width*.1,bottom: 20),
                width:Get.width ,
                height: 70,
                child: Image.asset('icons/welcome_signup.png')),
Container(
  margin: EdgeInsets.only(right: 15,bottom: 15),
    alignment: Alignment.topRight,
    child: Text('الاسم الشخصي',style: TextStyle(fontSize: 17),)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(

                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                      borderRadius: BorderRadius.circular(5),

                    )
                ),
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(right: 10,top: 25),
                width:Get.width*.88 ,
                height: 35,
                child: Image.asset('icons/email_auth.png',width: 100,)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Row(
                      children: [
                        SizedBox(width: 8,),
                        Text('+966',style: TextStyle(fontSize: 16,color: Colors.black),),
                        SizedBox(width: 2,),
                        Text('50214625',style: TextStyle(fontSize: 14,color: Colors.grey),
                        )
                      ],
                    ),
                    prefixStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                      borderRadius: BorderRadius.circular(5),

                    )
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(right: 10),
                width:Get.width*.88 ,
                height: 35,
                child: Image.asset('icons/phonenumber.png',width: 85,)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IntlPhoneField(
                         //   controller: phone,
                decoration:  InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                  labelText: '5xxxxxxxx'.tr,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                      borderRadius: BorderRadius.circular(5),

                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor,width: 2.0),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                initialCountryCode: 'SA',
                // onChanged: (value) {
                //   controller.phone = value.completeNumber;
                // },
                validator: (value) {
                  if (value!.number.isEmpty) {
                    return 'Please enter phone';
                  }
                  // regx
                  const pattern =
                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
                  final regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value.number)) {
                    return 'Please enter valid phone';
                  }
                  return null;
                },
              ),
            ),

            SizedBox(height: Get.height*.025,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 8,),
                Text('الشروط والاحكام',style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: mainColor,

                    fontSize: 16,color: mainColor,fontWeight: FontWeight.bold)),
                SizedBox(width: 2,),
                Text('الموافقه علي ',style: TextStyle(fontSize: 15,color: Colors.black),
                )
              ],
            ),
            SizedBox(height: Get.height*.02,),
            GestureDetector(
              onTap:(){
                Get.to(NavBarView());
              } ,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text('إنشاء حساب',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),
                width: Get.width,
                height: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:mainColor,
                    border: Border.all(color:mainColor,width: 1)
                ),
              ),
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}

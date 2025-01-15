import 'package:flutter/material.dart';
import 'package:fort_parts/constants.dart';
import 'package:get/get.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 90,),
            Container(
                width:100 ,
                height: 100,
                child: Image.asset('images/logo.png')),
 SizedBox(height: 40,),
 Container(
                width:Get.width*.5 ,
                height: Get.height*.18,
                child: Image.asset('icons/auth1.png'))
            , Container(
                width:Get.width*.5 ,
                height: Get.height*.15,
                child: Image.asset('icons/welcome_text.png')),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  title: Text('العربيه',style: TextStyle(fontSize: 20),),
                  leading: Icon(Icons.language,size: 30,),
                  trailing: Icon(Icons.keyboard_arrow_down_sharp,size: 35,),
                ),
              ),
              width: Get.width,
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(color:mainColor,width: 1)
              ),
            ),
            SizedBox(height: Get.height*.1,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 15),
child: Text('التالي',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),
              width: Get.width,
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color:mainColor,
                  border: Border.all(color:mainColor,width: 1)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

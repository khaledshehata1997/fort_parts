import 'package:flutter/material.dart';
import 'package:fort_parts/constants.dart';
import 'package:get/get.dart';

class ServiceHome extends StatelessWidget {
  const ServiceHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
       // backgroundColor: Colors.white,
        title: Text('السباكه',style: TextStyle(fontSize: 20,color: Colors.black),),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: EdgeInsets.only(top: 20,left: 5,right: 5),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              width: Get.width,
              height: Get.height*.18,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(blurRadius: 1,color: Colors.grey.shade300,spreadRadius: .025)
                ]
              ),
              child: Column(
                children: [
                  ListTile(
                    trailing: Container(
                      width: 80,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('icons/dollar.png',width: 20,height: 20,),
                          SizedBox(width: 5,),
                          Text('40 ريال',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color( 0XFF059E00)
                            ),),
                        ],
                      ),
                    ),
                    title: Text('تركيب سخانات ',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    leading: Container(
                      child: Container(
                          width: 15,height: 15,
                          child: Image.asset('icons/service.png')),
                      //margin: EdgeInsets.symmetric(vertical: 5),
                      width: Get.width*.22,
                      height: Get.height*.2,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                         borderRadius: BorderRadius.circular(6)
                      ),
                    ),
                    subtitle: Text(
                      maxLines: 2,
                      'نص تمثيلي لمحتوي معين يمثل وصف الخدمة المتاحة ',style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,color:Colors.black38 ,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(Icons.add,color: mainColor,),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                            border: Border.all(color: mainColor,width: 3)
                        ),
                      ),
                      SizedBox(width: 40,),
                      Text('2',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(width: 40,),
                      Container(
                        child: Icon(Icons.add,color: Colors.grey,),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                            border: Border.all(color: Colors.grey,width: 3)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

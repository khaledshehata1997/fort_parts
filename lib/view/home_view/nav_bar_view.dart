import 'package:flutter/material.dart';
import 'package:fort_parts/view/home_view/home_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../constants.dart';


class NavBarView extends StatelessWidget {
  List screens=[
    HomeView(),
    HomeView(),
    HomeView(),
    HomeView(),
  ];
  int index=2;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: mainColor,fontSize: 18
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.black45,fontSize: 18
        ),
        iconSize: 17,
        selectedFontSize: 18,
        showUnselectedLabels: true,
        showSelectedLabels: true,
         selectedIconTheme: IconThemeData(color: mainColor),
        fixedColor: Colors.black54,
        elevation: 10,
        backgroundColor: Colors.red,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon:Image.asset('icons/home.png'),label: 'الرئيسية' ),
          BottomNavigationBarItem(icon:Image.asset('icons/settings.png'),label: 'الطلبات' ),
          BottomNavigationBarItem(icon:Image.asset('icons/cart.png'),label: 'السلة' ),
          BottomNavigationBarItem(icon:Image.asset('icons/person.png'),label: 'الحساب' ),

        ],
      ),
      body:screens[index],
    );
  }
}

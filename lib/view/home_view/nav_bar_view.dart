import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:fort_parts/view/auth/sign_in_view.dart';
import 'package:fort_parts/view/cart_view/cart_view.dart';
import 'package:fort_parts/view/home_view/home_view.dart';
import 'package:fort_parts/view/profile_view/profile_view.dart';
import 'package:fort_parts/view/requests_view/requests_view.dart';
import 'package:local_storage/local_storage.dart';

import '../../constants.dart';

class NavBarView extends StatefulWidget {
  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const RequestsView(), // Replace this with your actual orders screen
    const CartScreen(),
    const ProfileScreen(), // Replace this with your actual account screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: mainColor,
          fontSize: 18,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.black45,
          fontSize: 18,
        ),
        iconSize: 17,
        selectedFontSize: 18,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(color: mainColor),
        fixedColor: Colors.black54,
        elevation: 10,
        backgroundColor: Colors.red,
        currentIndex: _currentIndex,
        onTap: (index) async {
          final HiveUser? user = await HiveHelper.get(hiveBox: HiveBoxes.user);
          if (user != null) {
            setState(() {
              _currentIndex = index;
            });
          } else {
            AppNavigator.navigateTo(
                type: NavigationType.navigateAndFinish, widget: SignInView());
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('icons/home.png'),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('icons/settings.png'),
            label: 'الطلبات',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('icons/cart.png'),
            label: 'السلة',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('icons/person.png'),
            label: 'الحساب',
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/view/cart_view/cart_view.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_states.dart';
import 'package:fort_parts/view/home_view/home_view.dart';
import 'package:fort_parts/view/profile_view/profile_view.dart';
import 'package:fort_parts/view/requests_view/requests_view.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutInitialState());

  int currentIndex = 0;

  List<Widget> screensBody = [
    const HomeView(),
    const RequestsView(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void changeScreenBody({
    required int index,
  }) async {
    if (currentIndex != index) {
      currentIndex = index;
      emit(HomeLayoutChangeBottomNavBarState());
    }
  }
}

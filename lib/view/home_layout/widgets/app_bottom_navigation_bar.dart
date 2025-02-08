import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_states.dart';
import 'package:fort_parts/view/home_layout/widgets/app_nav_bar_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeLayoutCubit>();
    return BlocBuilder<HomeLayoutCubit, HomeLayoutStates>(
      builder: (BuildContext context, state) => Container(
        margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 30.h),
        width: 375.w,
        height: 72.h,
        decoration: BoxDecoration(
          color: AppColors.fffffff,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [AppShadows.shadow3],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppNavBarItem(
                label: "الرئيسية",
                icon: AppImages.home,
                index: 0,
                color: cubit.currentIndex == 0 ? AppColors.fE0AA06 : AppColors.f949494,
              ),
              AppNavBarItem(
                label: "الطلبات",
                icon: AppImages.orders,
                index: 1,
                color: cubit.currentIndex == 1 ? AppColors.fE0AA06 : AppColors.f949494,
              ),
              AppNavBarItem(
                label: "السلة",
                icon: AppImages.cart,
                index: 2,
                color: cubit.currentIndex == 2 ? AppColors.fE0AA06 : AppColors.f949494,
              ),
              AppNavBarItem(
                label: "حسابي",
                icon: AppImages.profile,
                index: 3,
                color: cubit.currentIndex == 3 ? AppColors.fE0AA06 : AppColors.f949494,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

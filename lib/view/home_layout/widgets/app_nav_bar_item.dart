import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/view/auth/sign_in_view.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:local_storage/local_storage.dart';

class AppNavBarItem extends StatelessWidget {
  const AppNavBarItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.color,
    super.key,
  });

  final String icon;
  final String label;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeLayoutCubit>();
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (index == 2 || index == 3) {
            final HiveUser? user = await HiveHelper.get(hiveBox: HiveBoxes.user);
            if (user != null) {
              cubit.changeScreenBody(index: index);
            } else {
              AppNavigator.navigateTo(type: NavigationType.navigateAndFinish, widget: SignInView());
            }
          } else {
            cubit.changeScreenBody(index: index);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSVG(
              svgPath: icon,
              width: 30,
              height: 30,
              color: color.withValues(alpha: 0.84),
            ),
            SizedBox(height: 10.h),
            AppText(
              text: label,
              color: color,
              textStyles: AppTextStyles.bold12,
            ),
          ],
        ),
      ),
    );
  }
}

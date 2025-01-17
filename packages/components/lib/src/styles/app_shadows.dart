import 'package:components/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppShadows {
  static final BoxShadow shadow1 = BoxShadow(
    color: AppColors.f000000.withOpacity(0.08),
    offset: const Offset(0, 4),
    blurRadius: 8,
  );

  static final BoxShadow shadow2 = BoxShadow(
    color: AppColors.f000000.withOpacity(0.08),
    offset: const Offset(0, 4),
    blurRadius: 4,
  );
}

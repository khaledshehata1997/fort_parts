import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/view/home_view/home_view.dart';
import 'package:fort_parts/view/onboarding_view/onboarding_view.dart';
import 'package:is_first_run/is_first_run.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _containerController;
  late AnimationController _logoController;
  late Animation<double> _containerScaleAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();

    _containerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _containerScaleAnimation = Tween<double>(begin: 1.0, end: 10.0).animate(
      CurvedAnimation(parent: _containerController, curve: Curves.easeInOut),
    );
    _logoScaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _containerController.forward();
    _logoController.forward();

    Future.delayed(const Duration(seconds: 5)).then((_) async {
      final bool isFirstLogin = await IsFirstRun.isFirstRun();
      AppNavigator.navigateTo(
        type: NavigationType.navigateAndFinish,
        widget: isFirstLogin ? OnBordingView() : const HomeView(),
      );
    });
  }

  @override
  void dispose() {
    _containerController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _containerScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _containerScaleAnimation.value,
                  child: Container(
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      gradient: AppGradients.gradient1,
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _logoScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: Image.asset(
                    AppImages.splash,
                    width: 175.w,
                    height: 175.h,
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

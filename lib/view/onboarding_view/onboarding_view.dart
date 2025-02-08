import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_states.dart';
import 'package:fort_parts/view/home_view/nav_bar_view.dart';
import 'package:get/get.dart';

class OnBordingView extends StatefulWidget {
  @override
  State<OnBordingView> createState() => _OnBordingViewState();
}

class _OnBordingViewState extends State<OnBordingView> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextButtonPressed({
    required List<OnBoarding> onBoarding,
  }) {
    if (_currentIndex < onBoarding.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.to(NavBarView());
    }
  }

  @override
  void initState() {
    final cubit = context.read<SettingsCubit>();
    cubit.fetchOnBoarding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsStates>(
        buildWhen: (previous, current) => current is FetchOnBoardingState,
        builder: (context, state) {
          if (state is FetchOnBoardingState) {
            return Column(
              children: [
                SizedBox(
                  height: Get.height * .1,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Get.to(NavBarView());
                      },
                      child: Text("تخطي",
                          textDirection: TextDirection.rtl, style: TextStyle(fontSize: 20, color: mainColor, fontWeight: FontWeight.bold))),
                ),
                SizedBox(
                  height: Get.height * .025,
                ),
                state.stateStatus == StateStatus.success
                    ? Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: state.onBoarding.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppCachedNetworkImage(
                                    imageUrl: state.onBoarding[index].image,
                                    height: Get.height * 0.4,
                                    width: Get.height * 0.8,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.05,
                                  ),
                                  Text(
                                    state.onBoarding[index].title,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.05,
                                  ),
                                  Text(
                                    state.onBoarding[index].subTitle,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (state.stateStatus == StateStatus.success) {
                            _onNextButtonPressed(
                              onBoarding: state.onBoarding,
                            );
                          }
                        },
                        child: Text(
                          'التالي',
                          style: TextStyle(wordSpacing: 2, fontSize: 16, fontWeight: FontWeight.w600, color: mainColor),
                        )),
                    TextButton(
                        onPressed: () {
                          if (state.stateStatus == StateStatus.success) {
                            _onNextButtonPressed(
                              onBoarding: state.onBoarding,
                            );
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: mainColor,
                          radius: 25,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: Get.height * .1,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_states.dart';
import 'package:get/get.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int currentIndex = 0;
  @override
  void initState() {
    final cubit = context.read<SettingsCubit>();
    cubit.fetchHomeSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsStates>(
      buildWhen: (previous, current) => current is FetchHomeSliderState,
      builder: (BuildContext context, state) {
        if (state is FetchHomeSliderState) {
          return state.stateStatus == StateStatus.success
              ? Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 150.0,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            currentIndex = index;
                            setState(() {});
                          },
                          autoPlay: true),
                      items: state.slider.map((slider) {
                        return Container(
                            width: double.infinity,
                            margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AppCachedNetworkImage(
                                  imageUrl: slider.image,
                                  height: 150,
                                  width: Get.width,
                                )));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          state.slider.length,
                          (index) => Container(
                                height: 12,
                                width: 12,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == index
                                        ? mainColor
                                        : mainColor.withOpacity(0.3)),
                              )),
                    ),
                  ],
                )
              : AppShimmer(
                  child: Container(
                  width: double.infinity,
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                ));
        }
        return const SizedBox();
      },
    );
  }
}

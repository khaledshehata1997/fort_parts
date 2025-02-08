import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_states.dart';
import 'package:fort_parts/view/home_layout/widgets/app_bottom_navigation_bar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeLayoutCubit>();
    return BlocBuilder<HomeLayoutCubit, HomeLayoutStates>(
      builder: (context, state) {
        return AppScaffold(
          body: cubit.screensBody[cubit.currentIndex],
          bottomNavigationBar: const AppBottomNavigationBar(),
        );
      },
    );
  }
}

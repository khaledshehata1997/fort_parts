import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_states.dart';
import 'package:fort_parts/view/home_layout/widgets/app_bottom_navigation_bar.dart';
import 'package:location_services/location_services.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    LocationServices.fetchLocation();
    super.initState();
  }

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

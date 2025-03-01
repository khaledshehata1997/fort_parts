import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_states.dart';
import 'package:fort_parts/view/category_products_view/category_products_view.dart';
import 'package:get/get.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({super.key});

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  @override
  void initState() {
    final cubit = context.read<SettingsCubit>();
    cubit.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsStates>(
      buildWhen: (previous, current) => current is FetchCategoriesState,
      builder: (BuildContext context, state) {
        if (state is FetchCategoriesState) {
          return Expanded(
            child: GridView.count(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, bottom: 130.h, top: 10.h),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.6 / 1,
              crossAxisCount: 2,
              children: List.generate(
                state.stateStatus == StateStatus.success ? state.categories.length : 2,
                (int index) => state.stateStatus == StateStatus.success
                    ? InkWell(
                        onTap: () {
                          Get.to(CategoryProductsView(
                            category: state.categories[index],
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2)]),
                          child: Column(
                            children: [
                              AppCachedNetworkImage(
                                imageUrl: state.categories[index].image,
                                height: 65,
                                width: 65,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.categories[index].name,
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      )
                    : AppShimmer(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.6 / 1,
            ),
            itemCount: state.stateStatus == StateStatus.success ? state.categories.length : 2,
            itemBuilder: (context, index) {
              return state.stateStatus == StateStatus.success
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
                    boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppCachedNetworkImage(
                        imageUrl: state.categories[index].image,
                        height: 65,
                        width: 65,
                      ),
                      SizedBox(height: 5),
                      Text(
                        state.categories[index].name,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
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
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

}

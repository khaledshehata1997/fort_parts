import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_states.dart';
import 'package:fort_parts/view/category_products_view/widgets/category_product.dart';
import 'package:get/get.dart';

class CategoryProductsView extends StatefulWidget {
  const CategoryProductsView({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<CategoryProductsView> createState() => _CategoryProductsViewState();
}

class _CategoryProductsViewState extends State<CategoryProductsView> {
  @override
  void initState() {
    final cubit = context.read<SettingsCubit>();
    cubit.fetchProducts(categoryID: widget.category.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        // backgroundColor: Colors.white,
        title: Text(
          widget.category.name,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: EdgeInsets.only(top: 20, left: 5, right: 5),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: BlocBuilder<SettingsCubit, SettingsStates>(
              buildWhen: (previous, current) => current is FetchProductsSate,
              builder: (BuildContext context, state) {
                if (state is FetchProductsSate) {
                  return ListView.builder(
                      itemCount: state.stateStatus == StateStatus.success ? state.products.length : 2,
                      itemBuilder: (context, index) {
                        return state.stateStatus == StateStatus.success
                            ? CategoryProduct(product: state.products[index])
                            : AppShimmer(
                                child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                width: Get.width,
                                height: Get.height * .18,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey.shade300, spreadRadius: .025)]),
                              ));
                      });
                }
                return const SizedBox();
              },
            )),
      ),
    );
  }
}

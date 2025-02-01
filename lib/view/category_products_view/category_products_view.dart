import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_states.dart';
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
                      itemCount: state.stateStatus == StateStatus.success
                          ? state.products.length
                          : 2,
                      itemBuilder: (context, index) {
                        return state.stateStatus == StateStatus.success
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                width: Get.width,
                                height: Get.height * .18,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          color: Colors.grey.shade300,
                                          spreadRadius: .025)
                                    ]),
                                child: Column(
                                  children: [
                                    ListTile(
                                      trailing: Container(
                                        width: 80,
                                        height: 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              'icons/dollar.png',
                                              width: 20,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${state.products[index].price} ريال',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFF059E00)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      title: Text(
                                        state.products[index].name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      leading: AppCachedNetworkImage(
                                        imageUrl: state.products[index].image,
                                        height: Get.height * .2,
                                        width: Get.width * .22,
                                        radius: 6,
                                      ),
                                      subtitle: Text(
                                        maxLines: 2,
                                        state.products[index].description,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.add,
                                            color: mainColor,
                                          ),
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: mainColor, width: 3)),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          '2',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.grey,
                                          ),
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 3)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : AppShimmer(
                                child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                width: Get.width,
                                height: Get.height * .18,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          color: Colors.grey.shade300,
                                          spreadRadius: .025)
                                    ]),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_cubit.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_states.dart';
import 'package:fort_parts/view/cart_view/payment_view.dart';
import 'package:fort_parts/view/cart_view/widgets/cart_item_card.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    final cubit = context.read<CartCubit>();
    cubit.fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('السلة', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<CartCubit, CartStates>(
                  buildWhen: (previous, current) => current is FetchCartState,
                  builder: (context, state) {
                    if (state is FetchCartState) {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return CartItemCard(
                            product: cubit.cart.products[index].product,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 16);
                        },
                        itemCount: cubit.cart.products.length,
                      );
                    }
                    return const SizedBox();
                  }),
              // First Item Card

              // Total Amount Section
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.monetization_on_outlined, size: 30, color: mainColor),
                                  SizedBox(width: 8),
                                  BlocBuilder<CartCubit, CartStates>(builder: (context, state) {
                                    return Text(
                                      'المبلغ الإجمالي : ${cubit.cart.total} جنيه',
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          if (cubit.cart.products.isNotEmpty) {
                            Get.to(const PaymentView());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          minimumSize: Size(double.infinity, 60), // Increased height (60)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Less rounded corners (8)
                          ),
                        ),
                        child: const Text(
                          'تأكيد الطلب',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // // Bottom Navigation Bar
              // BottomNavigationBar(
              //   currentIndex: 0,
              //   items: [
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.home),
              //       label: 'الرئيسية',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.shopping_cart),
              //       label: 'السلة',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.person),
              //       label: 'الحساب',
              //     ),
              //   ],
              // ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}

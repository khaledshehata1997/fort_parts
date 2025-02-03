import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_cubit.dart';
import 'package:fort_parts/view/cart_view/payment_view.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('السلة', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Item Card
            CartItemCard(
              title: 'تصاميم اللوحية',
              subtitle: 'نص فرعي - تفاصيل - شرح توضيحي',
              price: 800,
              quantity: 2,
              iconColor: Colors.green,
              icon: Icons.tv,
            ),
            SizedBox(height: 16),
            // Second Item Card
            CartItemCard(
              title: 'تصاميم التسويقية',
              subtitle: 'نص فرعي - تفاصيل - شرح توضيحي',
              price: 400,
              quantity: 1,
              iconColor: Colors.red,
              icon: Icons.straighten,
            ),
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
                                Text(
                                  'المبلغ الإجمالي : 1200 جنيه',
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.05),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(const PaymentView());
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
          ],
        ),
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final int quantity;
  final Color iconColor;
  final IconData icon;

  const CartItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double size = 30;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: iconColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_box_outlined,
                        size: 37,
                      ),
                      onPressed: () {},
                      color: mainColor,
                    ),
                  ),
                  Text('$quantity'),
                  quantity != 1
                      ? Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 25),
                          child: Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(size * 0.2), // Rounded outer box
                            ),
                            child: Center(
                              child: Container(
                                width: size * 0.8,
                                height: size * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(size * 0.15), // Rounded inner box
                                ),
                                child: Center(
                                  child: Container(
                                    width: size * 0.5, // Width of the minus line
                                    height: size * 0.1, // Thickness of the minus line
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 25),
                          child: Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(size * 0.2), // Rounded outer box
                            ),
                            child: Center(
                              child: Container(
                                width: size * 0.8,
                                height: size * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(size * 0.15), // Rounded inner box
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                )),
                              ),
                            ),
                          ),
                        )
                ],
              ),
              Text(
                '$price جنيه',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

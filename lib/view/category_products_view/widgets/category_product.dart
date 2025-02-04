import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_cubit.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_states.dart';
import 'package:get/get.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({super.key, required this.product});

  final Product product;

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  String fetchQuantity() {
    final cubit = context.read<CartCubit>();

    final CartProduct? cartProduct = cubit.cart.products.firstWhereOrNull((element) => element.product == widget.product);

    if (cartProduct != null) {
      return cartProduct.quantity.toString();
    }
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      width: Get.width,
      height: Get.height * .18,
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey.shade300, spreadRadius: .025)]),
      child: Column(
        children: [
          ListTile(
            trailing: Container(
              width: 80,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                    '${widget.product.price} ريال',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0XFF059E00)),
                  ),
                ],
              ),
            ),
            title: Text(
              widget.product.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            leading: AppCachedNetworkImage(
              imageUrl: widget.product.image,
              height: Get.height * .2,
              width: Get.width * .22,
              radius: 6,
            ),
            subtitle: Text(
              maxLines: 2,
              widget.product.description,
              style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 14, color: Colors.black38, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  final cubit = context.read<CartCubit>();
                  final CartProduct? cartProduct = cubit.cart.products.firstWhereOrNull((element) => element.product == widget.product);

                  cubit.updateItemInCartState(
                    productID: widget.product.id,
                    quantity: cartProduct != null ? cartProduct.quantity + 1 : 1,
                  );
                },
                child: Container(
                  child: Icon(
                    Icons.add,
                    color: mainColor,
                  ),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white, border: Border.all(color: mainColor, width: 3)),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              BlocBuilder<CartCubit, CartStates>(
                builder: (BuildContext context, s) {
                  return s is UpdateItemInCartState && s.stateStatus == StateStatus.loading
                      ? CircularProgressIndicator()
                      : Text(
                          fetchQuantity(),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        );
                },
              ),
              SizedBox(
                width: 40,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  final cubit = context.read<CartCubit>();
                  final CartProduct? cartProduct = cubit.cart.products.firstWhereOrNull((element) => element.product == widget.product);

                  if (cartProduct != null && cartProduct.quantity > 1) {
                    cubit.updateItemInCartState(
                      productID: widget.product.id,
                      quantity: cartProduct.quantity - 1,
                    );
                  } else if (cartProduct != null && cartProduct.quantity == 1) {
                    cubit.deleteItemFromCart(
                      productID: widget.product.id,
                    );
                  }
                },
                child: Container(
                  child: Icon(
                    Icons.minimize,
                    color: Colors.grey,
                  ),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white, border: Border.all(color: Colors.grey, width: 3)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

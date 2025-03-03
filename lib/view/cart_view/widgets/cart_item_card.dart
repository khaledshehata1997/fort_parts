import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_cubit.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_states.dart';
import 'package:get/get.dart';

class CartItemCard extends StatefulWidget {
  final Product product;

  const CartItemCard({
    super.key,
    required this.product,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool isLoading = false;

  String fetchQuantity() {
    final cubit = context.read<CartCubit>();

    final CartProduct? cartProduct = cubit.cart.products.firstWhereOrNull((element) => element.product == widget.product);

    if (cartProduct != null) {
      return cartProduct.quantity.toString();
    }
    cubit.fetchCart();
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    double size = 30;
    return Card(
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
                AppCachedNetworkImage(
                  imageUrl: widget.product.image,
                  height: 80,
                  width: 80,
                  radius: 8,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.description,
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
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    final cubit = context.read<CartCubit>();
                    setState(() {
                      isLoading = true;
                    });
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white, border: Border.all(color: mainColor, width: 3)),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                BlocConsumer<CartCubit, CartStates>(
                  listener: (BuildContext context, s) {
                    if ((s is UpdateItemInCartState && s.stateStatus == StateStatus.success) ||
                        (s is DeleteItemFromCartState && s.stateStatus == StateStatus.success)) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  builder: (BuildContext context, s) {
                    return isLoading
                        ? CupertinoActivityIndicator()
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
                    setState(() {
                      isLoading = true;
                    });
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4), color: Colors.white, border: Border.all(color: Colors.grey, width: 3)),
                  ),
                ),
              ],
            ),
            Text(
              '${widget.product.price} جنيه',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

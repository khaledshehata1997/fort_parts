import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/coupon_cubit/coupon_cubit.dart';
import 'package:get/get.dart';

class CouponItem extends StatelessWidget {
  const CouponItem({
    super.key,
    required this.coupon,
    required this.isExpired,
  });

  final Coupon coupon;
  final bool isExpired;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Coupon Icon
          AppCachedNetworkImage(
            imageUrl: coupon.image,
            height: 40,
            width: 40,
            radius: 8,
          ),
          const SizedBox(width: 16),
          // Coupon Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      coupon.value.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(width: 10),
                    Text(
                      coupon.type == "value" ? "SAR".tr : "%",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  coupon.expiryDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Activation Switch
          if (!isExpired)
            Switch(
              value: coupon.isActive,
              onChanged: (value) {
                if (!coupon.isActive) {
                  final cubit = context.read<CouponCubit>();
                  cubit.activateCoupon(couponID: coupon.id);
                }
              },
              activeColor: Colors.green,
            ),
        ],
      ),
    );
  }
}

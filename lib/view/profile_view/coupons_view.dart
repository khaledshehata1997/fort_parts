import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/coupon_cubit/coupon_cubit.dart';
import 'package:fort_parts/controllers/coupon_cubit/coupon_states.dart';
import 'package:fort_parts/view/profile_view/widgets/coupon_item.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  void initState() {
    final cubit = context.read<CouponCubit>();
    cubit.fetchCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            'الكوبونات',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: [
              Tab(text: 'المنتهية'),
              Tab(text: 'المتاحة'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Expired Coupons
            ExpiredCouponsTab(),
            // Available Coupons
            AvailableCouponsTab(),
          ],
        ),
      ),
    );
  }
}

class AvailableCouponsTab extends StatelessWidget {
  const AvailableCouponsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<CouponCubit, CouponStates>(
        buildWhen: (previous, current) => current is FetchCouponsState,
        builder: (BuildContext context, state) {
          if (state is FetchCouponsState) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemBuilder: (BuildContext context, int index) {
                return state.stateStatus == StateStatus.success
                    ? CouponItem(
                        coupon: state.coupons!.active[index],
                        isExpired: false,
                      )
                    : AppShimmer(
                        child: Container(
                          width: 343.w,
                          height: 114.h,
                          decoration: BoxDecoration(
                            color: AppColors.fffffff,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 16.h);
              },
              itemCount: state.stateStatus == StateStatus.success ? state.coupons!.active.length : 3,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class ExpiredCouponsTab extends StatelessWidget {
  const ExpiredCouponsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<CouponCubit, CouponStates>(
        buildWhen: (previous, current) => current is FetchCouponsState,
        builder: (BuildContext context, state) {
          if (state is FetchCouponsState) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemBuilder: (BuildContext context, int index) {
                return state.stateStatus == StateStatus.success
                    ? CouponItem(
                        coupon: state.coupons!.expired[index],
                        isExpired: true,
                      )
                    : AppShimmer(
                        child: Container(
                          width: 343.w,
                          height: 114.h,
                          decoration: BoxDecoration(
                            color: AppColors.fffffff,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 16.h);
              },
              itemCount: state.stateStatus == StateStatus.success ? state.coupons!.expired.length : 3,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

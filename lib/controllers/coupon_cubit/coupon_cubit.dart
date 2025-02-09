import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/coupon_cubit/coupon_states.dart';

class CouponCubit extends Cubit<CouponStates> {
  CouponCubit() : super(CouponInitialState());

  Future<void> fetchCoupons() async {
    try {
      emit(FetchCouponsState(stateStatus: StateStatus.loading));
      final Coupons coupons = await sl<ICouponRepository>().fetchCoupons();

      emit(FetchCouponsState(
        stateStatus: StateStatus.success,
        coupons: coupons,
      ));
    } catch (e) {
      emit(FetchCouponsState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> activateCoupon({
    required int couponID,
  }) async {
    try {
      emit(FetchCouponsState(stateStatus: StateStatus.loading));
      final Coupons coupons = await sl<ICouponRepository>().activateCoupon(
        couponID: couponID,
      );

      emit(FetchCouponsState(stateStatus: StateStatus.success, coupons: coupons));
    } catch (e) {
      emit(FetchCouponsState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}

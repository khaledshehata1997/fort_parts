import 'package:components/components.dart';
import 'package:data_access/data_access.dart';

class CouponStates {}

class CouponInitialState extends CouponStates {}

class CouponRefreshState extends CouponStates {}

class FetchCouponsState extends CouponStates {
  FetchCouponsState({
    required this.stateStatus,
    this.coupons,
  });
  final StateStatus stateStatus;
  final Coupons? coupons;
}

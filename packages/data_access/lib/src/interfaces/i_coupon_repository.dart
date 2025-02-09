import 'package:data_access/data_access.dart';

abstract class ICouponRepository {
  Future<Coupons> fetchCoupons();

  Future<Coupons> activateCoupon({
    required int couponID,
  });
}

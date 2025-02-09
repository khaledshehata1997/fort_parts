import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class CouponRepository implements ICouponRepository {
  @override
  Future<Coupons> fetchCoupons() async {
    try {
      final String url = EndPoints.fetchCoupons();

      final Response response = await sl<IApiRepository>().get(url: url);

      final Coupons coupons = Coupons.fromJson(response.data['data']);

      return coupons;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Coupons> activateCoupon({
    required int couponID,
  }) async {
    try {
      final String url = EndPoints.activateCoupon();
      final Map<String, dynamic> data = {'id': couponID};

      final Response response = await sl<IApiRepository>().post(url: url, formData: FormData.fromMap(data));
      final Coupons coupons = Coupons.fromJson(response.data['data']);

      return coupons;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class SettingsRepository implements ISettingsRepository {
  @override
  Future<Settings> fetchSettings() async {
    try {
      final String url = EndPoints.settings();

      final Response response = await sl<IApiRepository>().get(url: url);
      final Settings settings = Settings.fromJson(response.data['data']);
      return settings;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> fetchCategories() async {
    try {
      final String url = EndPoints.categories();

      final Response response = await sl<IApiRepository>().get(url: url);
      final List<Category> categories = List<Category>.from(
          response.data['data'].map((x) => Category.fromJson(x)));
      return categories;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> fetchCategoryProducts({
    required int categoryID,
  }) async {
    try {
      final String url = EndPoints.categoryProducts(categoryID: categoryID);

      final Response response = await sl<IApiRepository>().get(url: url);
      final List<Product> products = List<Product>.from(
          response.data['data'].map((x) => Product.fromJson(x)));
      return products;
    } catch (e) {
      rethrow;
    }
  }
}

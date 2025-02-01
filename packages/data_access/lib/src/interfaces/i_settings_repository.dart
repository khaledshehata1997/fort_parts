import 'package:data_access/data_access.dart';

abstract class ISettingsRepository {
  Future<Settings> fetchSettings();

  Future<List<Category>> fetchCategories();

  Future<List<Product>> fetchCategoryProducts({required int categoryID});
}

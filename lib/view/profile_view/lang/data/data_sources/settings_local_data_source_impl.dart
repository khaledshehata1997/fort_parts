import 'dart:ui';

import 'package:fort_parts/view/profile_view/lang/data/data_sources/settings_local_data_source.dart';
import 'package:get/get.dart';

import '../../../../../translations/app_strings.dart';
import '../../../../../translations/helper.dart';
import '../../../../../translations/prefs.dart';

class SettingsLocalDataSourceImpl extends SettingsLocalDataSource{




  @override
  Future<void> changeLanguage() async{

    final currentLocal = Get.locale;
    if (currentLocal!.countryCode == 'AR') {
      var locale = const Locale('en', 'US');
      Get.updateLocale(locale);
      Helper.setDefaultLang(AppStrings.enCountryCode);
      Prefs.setString(AppStrings.local, AppStrings.enCountryCode);
    } else {
      var locale = const Locale('ar', 'AR');
      Get.updateLocale(locale);
      Helper.setDefaultLang(AppStrings.arCountryCode);
      Prefs.setString(AppStrings.local, AppStrings.arCountryCode);

    }
  }
}
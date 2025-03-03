import 'package:fort_parts/translations/prefs.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_strings.dart';


class Helper{

  static String getCurrentLocal(){
    String local = AppStrings.enCountryCode;
    final currentLocal = Get.locale;
    local = currentLocal!.countryCode!;
    if(local == 'US'){
      AppStrings.appLocal = 'en';
    } else {
      AppStrings.appLocal = 'ar';
    }
    return local;
  }


  static setDefaultLang(String lang) async => Prefs.setString(AppStrings.local, lang);

  static getDefaultLanguage() async{
    if(Prefs.isContain(AppStrings.local)){
      if(Prefs.getString(AppStrings.local) == AppStrings.enCountryCode){
        var locale = const Locale('en', 'US');
        Get.updateLocale(locale);
        return;
      }
      var locale = const Locale('ar', 'AR');
      Get.updateLocale(locale);
    }
  }
}
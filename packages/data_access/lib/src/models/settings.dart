import 'package:data_access/data_access.dart';

class Settings {
  Settings({
    required this.setting,
    required this.slider,
    required this.onBoarding,
  });

  final Setting setting;
  final List<Slider> slider;
  final List<OnBoarding> onBoarding;

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      setting: Setting.fromJson(json['setting']),
      slider: List<Slider>.from(json['slider'].map((x) => Slider.fromJson(x))),
      onBoarding: List<OnBoarding>.from(json['splech'].map((x) => OnBoarding.fromJson(x))),
    );
  }
}

class Setting {
  Setting({
    required this.name,
  });

  final String name;

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      name: json['name'],
    );
  }
}

import 'package:components/components.dart';
import 'package:data_access/data_access.dart';

class SettingsStates {}

class SettingsInitialState extends SettingsStates {}

class SettingsRefreshState extends SettingsStates {}

class FetchHomeSliderState extends SettingsStates {
  FetchHomeSliderState({
    required this.stateStatus,
    this.slider = const [],
  });
  final StateStatus stateStatus;
  final List<Slider> slider;
}

class FetchOnBoardingState extends SettingsStates {
  FetchOnBoardingState({
    required this.stateStatus,
    this.onBoarding = const [],
  });
  final StateStatus stateStatus;
  final List<OnBoarding> onBoarding;
}

class FetchCategoriesState extends SettingsStates {
  FetchCategoriesState({
    required this.stateStatus,
    this.categories = const [],
  });
  final StateStatus stateStatus;
  final List<Category> categories;
}

class FetchProductsSate extends SettingsStates {
  FetchProductsSate({
    required this.stateStatus,
    this.products = const [],
  });
  final StateStatus stateStatus;
  final List<Product> products;
}

class FetchTermsAndConditionsState extends SettingsStates {
  FetchTermsAndConditionsState({
    required this.stateStatus,
    this.termsAndConditions = "",
  });
  final StateStatus stateStatus;
  final String termsAndConditions;
}

class FetchPostToMoneyState extends SettingsStates {
  FetchPostToMoneyState({
    required this.stateStatus,
    this.pos = 0,
  });
  final StateStatus stateStatus;
  final int pos;
}

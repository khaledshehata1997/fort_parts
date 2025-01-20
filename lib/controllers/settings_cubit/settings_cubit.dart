import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  Future<void> fetchHomeSlider() async {
    try {
      emit(FetchHomeSliderState(stateStatus: StateStatus.loading));
      final Settings settings = await sl<ISettingsRepository>().fetchSettings();

      emit(FetchHomeSliderState(
        stateStatus: StateStatus.success,
        slider: settings.slider,
      ));
    } catch (e) {
      emit(FetchHomeSliderState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> fetchOnBoarding() async {
    try {
      emit(FetchOnBoardingState(stateStatus: StateStatus.loading));
      final Settings settings = await sl<ISettingsRepository>().fetchSettings();

      emit(FetchOnBoardingState(
        stateStatus: StateStatus.success,
        onBoarding: settings.onBoarding,
      ));
    } catch (e) {
      emit(FetchOnBoardingState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> fetchCategories() async {
    try {
      emit(FetchCategoriesState(stateStatus: StateStatus.loading));
      final List<Category> categories = await sl<ISettingsRepository>().fetchCategories();

      emit(FetchCategoriesState(
        stateStatus: StateStatus.success,
        categories: categories,
      ));
    } catch (e) {
      emit(FetchCategoriesState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/view/profile_view/lang/cubit/lang_state.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../../translations/app_strings.dart';
import '../domain/use_cases/settings_change_lang_usecase.dart';



class LangCubit extends Cubit<LangState>{

  final LangChangeLangUseCase settingsChangeLangUseCase;
  LangCubit({required this.settingsChangeLangUseCase}) : super(SettingsInitial());

  void initLoginPage() => emit(SettingsInitial());


  Future<void> changeLang() async{
    emit(SettingsIsLoading());
    Either<Failures , NoParams> response = await settingsChangeLangUseCase(NoParams());
    emit(response.fold(
            (failures) => SettingsError(msg: failures.msg),
            (_) => SettingsLoadedWithoutData()));
  }

  String mapFailureToMsg(Failures failures){
    switch (failures.runtimeType){
      case const (ServerFailure):
        return AppStrings.serverError;
      case const (CashFailure):
        return AppStrings.cacheError;
      default:
        return AppStrings.unexpectedError;
    }
  }

}
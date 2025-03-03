import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../repositories/setting_repository.dart';

class LangChangeLangUseCase implements UseCase<NoParams , NoParams>{

  final SettingRepository settingRepository;
  LangChangeLangUseCase({required this.settingRepository});

  @override
  Future<Either<Failures, NoParams>> call(NoParams params) => settingRepository.changeLanguage();

}
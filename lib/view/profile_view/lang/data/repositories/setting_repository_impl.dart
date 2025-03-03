import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';
import '../../domain/repositories/setting_repository.dart';
import '../data_sources/settings_local_data_source.dart';

class SettingsRepositoryImpl extends SettingRepository{

  final SettingsLocalDataSource settingsLocalDataSource;


  SettingsRepositoryImpl({required this.settingsLocalDataSource});


  @override
  Future<Either<Failures, NoParams>> changeLanguage() async{
    try {
      final data = await settingsLocalDataSource.changeLanguage();
      return Right(NoParams());
    } on FetchDataException {
      return Left(ServerFailure(msg: 'error'.tr));
    }
  }
}
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/use_case.dart';


abstract class SettingRepository {

  Future<Either<Failures , NoParams>>  changeLanguage();

}
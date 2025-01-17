import 'package:data_access/data_access.dart';
import 'package:local_storage/local_storage.dart';

extension ToHiveUser on User {
  HiveUser get toHiveUser {
    return HiveUser(
      id: id,
    );
  }
}

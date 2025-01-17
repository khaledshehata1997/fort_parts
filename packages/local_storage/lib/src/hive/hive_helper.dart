import 'dart:convert';
import 'dart:developer';

import 'package:components/components.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_storage/local_storage.dart';
import 'package:local_storage/src/hive/keys.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static init() async {
    await Hive.initFlutter();
    await _registerAdapters();
    await _encryption();
  }

  static Future<void> _encryption() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final bool containsEncryptionKey = await secureStorage.containsKey(key: HiveKeys.encryptionKey);
    if (!containsEncryptionKey) {
      List<int> key = Hive.generateSecureKey();
      await secureStorage.write(key: HiveKeys.encryptionKey, value: base64UrlEncode(key));
    }
  }

  static Future<void> _registerAdapters() async {
    Hive.registerAdapter(HiveAccessTokenAdapter());
    Hive.registerAdapter(HiveUserAdapter());
  }

  static Future<Box> _openBox({
    required HiveBoxes hiveBox,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final String? key = await secureStorage.read(key: HiveKeys.encryptionKey);
    List<int> encryptionKey = base64Url.decode(key.toString());

    try {
      switch (hiveBox) {
        case HiveBoxes.user:
          final Box box = await Hive.openBox(
            HiveBoxes.user.toBoxName,
            path: directory.path,
            encryptionCipher: HiveAesCipher(encryptionKey),
          );
          return box;
        case HiveBoxes.accessToken:
          final Box box = await Hive.openBox(
            HiveBoxes.accessToken.toBoxName,
            path: directory.path,
            encryptionCipher: HiveAesCipher(encryptionKey),
          );
          return box;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<void> put({
    required HiveBoxes hiveBox,
    required dynamic data,
  }) async {
    final Box box = await _openBox(
      hiveBox: hiveBox,
    );
    await box.put(0, data);
    await box.close();
  }

  static Future<dynamic> get({
    required HiveBoxes hiveBox,
  }) async {
    final Box box = await _openBox(
      hiveBox: hiveBox,
    );
    var result = await box.get(0);
    await box.close();
    return result;
  }

  static Future<void> deleteDB() async {
    final directory = await getApplicationDocumentsDirectory();

    //Delete USer Box
    await Hive.deleteBoxFromDisk(
      HiveBoxes.user.toBoxName,
      path: directory.path,
    );

    //Delete Session Token Box
    await Hive.deleteBoxFromDisk(
      HiveBoxes.accessToken.toBoxName,
      path: directory.path,
    );

    log('Hive Database cleared Successfully');
  }
}

extension on HiveBoxes {
  String get toBoxName {
    switch (this) {
      case HiveBoxes.user:
        return 'user';
      case HiveBoxes.accessToken:
        return 'accessToken';
    }
  }
}

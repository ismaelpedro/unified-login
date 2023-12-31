import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/services/local_storage/local_storage_interface.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  Completer<Box> completer = Completer<Box>();

  ///Name of box
  final String boxName = "login_storage";

  LocalStorageServiceImpl() {
    _init();
  }

  ///Start Hive box
  Future _init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    final box = await Hive.openBox(boxName);
    if (!completer.isCompleted) completer.complete(box);
  }

  ///Read a stored document..
  @override
  Future<Map<String, dynamic>?> read(String directory) async {
    final box = await completer.future;

    try {
      if (box.containsKey(directory)) {
        return Map<String, dynamic>.from(box.get(directory));
      }
    } catch (e) {
      debugPrint("Failed at write documents: $e");
    }
    return null;
  }

  ///Write a [document] in a [directory].
  @override
  write(dynamic documents, {String? directory}) async {
    final box = await completer.future;

    try {
      await box.put('$directory', documents);
    } catch (e) {
      debugPrint("Failed at write documents: $e");
    }
  }

  ///Clear hive data
  @override
  Future clear() async {
    final box = await completer.future;

    try {
      await box.clear();
    } catch (e) {
      debugPrint("Failed at clear hive data: $e");
    }
  }

  ///Check if a directory exists in box.
  @override
  Future<bool> checkIfDirectoryExists(String directory) async {
    final box = await completer.future;

    try {
      if (box.containsKey(directory)) return true;
    } catch (e) {
      debugPrint("Failed check if directory exists: $e");
    }

    return false;
  }

  ///Write the version of document.
  @override
  writeVersion(String version) async {
    final box = await completer.future;
    try {
      await box.put('version', version);
    } catch (e) {
      debugPrint("Failed at write version data: $e");
    }
  }

  ///Check if version of documents _hived in device is most updated.
  @override
  Future<bool> checkVersion(String lastVersion) async {
    final box = await completer.future;

    try {
      if (box.containsKey('version')) {
        String version = box.get('version');
        if (lastVersion == version) return true;
      }
    } catch (e) {
      debugPrint("Failed at check version data: $e");
    }
    return false;
  }

  ///Read from storage directory to get user data,
  ///if none data was found then returns null, else returns a [UserModel].
  @override
  Future<Map<String, dynamic>?> readUser() async {
    final box = await completer.future;
    try {
      if (box.containsKey('user')) {
        return Map<String, dynamic>.from(box.get("user"));
      }
    } catch (e) {
      debugPrint("Failed at read user data: $e");
    }
    return null;
  }

  ///Write user data on storage.
  @override
  Future<void> writeUser(Map<String, dynamic> user) async {
    final box = await completer.future;
    try {
      await box.put("user", user);
    } catch (e) {
      debugPrint("Failed at write user data: $e");
    }
  }

  ///Clear all user data on storage. Should call this function
  ///when user is disconnecting account.
  @override
  Future clearLogout() async {
    final box = await completer.future;
    try {
      if (box.containsKey('user')) box.delete('user');
    } catch (e) {
      debugPrint("Failed at clear user data: $e");
    }
  }
}

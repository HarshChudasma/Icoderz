import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// TODO Preference Service

PrefService prefs = PrefService.instance;

class PrefService extends GetxController {
  static final PrefService instance = PrefService();

  GetStorage storage = GetStorage();

  dynamic getValue({required String key}) {
    return storage.read(key);
  }

  Future<void> setValue({required String key, dynamic value}) async {
    await storage.write(key, value);
  }

  Future<void> removeValue(String key) async {
    await storage.remove(key);
  }
}
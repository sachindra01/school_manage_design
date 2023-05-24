import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write('apiToken', token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read('apiToken');
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove('apiToken');
  }
}

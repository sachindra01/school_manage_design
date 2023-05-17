import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write('apiToken', token);
    return true;
  }

  getToken() {
    final box = GetStorage();
    var apiToken = box.read('apiToken'); 
    return apiToken;
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove('apiToken');
  }
}
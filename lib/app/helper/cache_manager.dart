import 'package:school_management_app/app/common/read_write.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    await write('apiToken', token);
    return true;
  }

  getToken() {
    var apiToken = read('apiToken'); 
    return apiToken;
  }

  Future<void> removeToken() async {
    await remove('apiToken');
  }
}
import 'package:get/get.dart';
import 'package:school_management_app/app/helper/cache_manager.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;

  logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;
    //Token is cached
    await saveToken(token);
  }

  void checkLoginStatus() async {
    final token = await getToken();
    if (token!='') {
      isLogged.value = true;
    }
  }
}

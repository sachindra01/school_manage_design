// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/app/common/toast_message.dart';
import 'package:school_management_app/app/helper/auth_manager.dart';
import 'package:school_management_app/app/modules/auth/views/repo.dart';
import 'package:local_auth/local_auth.dart';
import 'package:school_management_app/bottom_nav.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  var  loginResponse;
  final AuthServices _authServices =AuthServices();
  final LocalAuthentication auth = LocalAuthentication();
  var billingDate;
  bool canAuthenticateWithBio = false;
  bool canUseBiometic = false;
  final AuthenticationManager authManager=AuthenticationManager();


  getLogin(email,password) async {
    try {
      isLoading(true);
      var response = await _authServices.fetchLogin(email,password);
        write('loginInfopassword',  password);
      if(response != null){
        loginResponse = response;
        Get.off(()=>const BottomNavbar(
          index: 2,
        ));
        write('loginInfoemail',  loginResponse.data.data.user.email);
        write('apiToken', loginResponse.data.token);
         authManager.login( loginResponse.data.token);

         showToastMessage(loginResponse.message);
       

      } else {
        debugPrint('Cannot retrieve billing data');
      }
    } finally {
      isLoading(false);
      update();
    }
  }
  canUseBiometric() async {
    final bool canAuthenticateWithBiometrics  = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    var biometricsEnabled = read('biometricsEnabled') == "" ? false : read('biometricsEnabled') == false ? false : true;
    canAuthenticateWithBio = canAuthenticate;
    if(canAuthenticate&&biometricsEnabled) {
      canUseBiometic = true;
    } else {
      canUseBiometic = false;
    }
  }

  authenticate(context) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(useErrorDialogs: true, biometricOnly: true)
      );
      if(didAuthenticate) {
        var datamail = read('loginInfoemail');
        var datapassword = read('loginInfopassword');
        await getLogin(datamail, datapassword,);
      }
    // ignore: empty_catches
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
 

}
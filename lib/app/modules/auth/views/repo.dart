import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_management_app/app/common/toast_message.dart';
import 'package:school_management_app/app/core/dio/dio_client.dart';
import 'package:school_management_app/app/modules/auth/views/model.dart';

class AuthServices {
  var box=GetStorage();
  Future<LoginResponse?> fetchLogin(email,password) async {
    try {
      final response = await dio.post(
        'api/institute/login',
        data: {
          'email':email,
          'password':password
        },
      );

      if (response.statusCode == 200) {
        final data = LoginResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }

    } on DioError catch (e) {
        showToastMessage(e.message);
      log(e.message.toString());
     
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
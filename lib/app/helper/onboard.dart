import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/helper/auth_manager.dart';
import 'package:school_management_app/app/modules/auth/views/login_screen.dart';
import 'package:school_management_app/app/modules/home/views/home_screen.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager authManager = Get.find();

    return Obx(() {
      return authManager.isLogged.value
          ? const HomeScreen(
            )
          : const LoginScreen();
    });
  }
}

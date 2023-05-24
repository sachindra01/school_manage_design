import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/app/modules/auth/views/login_screen.dart';
import 'package:school_management_app/app/modules/home/views/home_screen.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return read('apiToken')!=''
          ? const HomeScreen(
            )
          : const LoginScreen();
  }
}

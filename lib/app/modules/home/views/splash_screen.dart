import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/auth/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 3), () async {
    //   Get.off(() => const LoginScreen());
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundColor: lBlack,
              child: AnimatedSplashScreen(
                backgroundColor: primaryColor,
                curve: Curves.ease,
                splash: 'assets/img/logo.jpg',
                nextScreen: const LoginScreen(),
                splashTransition: SplashTransition.rotationTransition,
              ),
            ),
          ),
          Expanded(child: Container()),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: () {},
            child: const Text('CODENT ACADEMIC',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.purple)),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/helper/auth_manager.dart';
import 'package:school_management_app/app/helper/onboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  @override
  void initState() {
    initializeSettings();
    Future.delayed(const Duration(seconds: 3), () async {
      Get.off(() => const OnBoard());
    });
    // if(read('isDarkMode') == null || read('isDarkMode') == "") {
    //     write('isDarkMode', Get.isDarkMode);
    //   } else {
    //     Get.changeThemeMode(
    //       read('isDarkMode') ? ThemeMode.dark : ThemeMode.light
    //     );
    //   }

    super.initState();
  }
  initializeSettings() async {
    _authmanager.checkLoginStatus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lWhite,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
            // colors: [Colors.deepPurple, Colors.purple],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(220, 46, 36, 72),
            // Color.fromARGB(255, 230, 149, 45),
            Color.fromARGB(255, 223, 104, 144),
              ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          ),

        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            CircleAvatar(
                radius:80,
                backgroundColor: lWhite,
                child: Padding(
                  padding: const EdgeInsets.all(2), // Border radius
                  child:
                      ClipOval(child: Image.asset('assets/img/logo.jpg')),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              animatedText(),
            Expanded(child: Container()),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () {},
              child: const Text('Version 1.0.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color:lWhite)),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
  animatedText(){
    return  DefaultTextStyle(
      style: const TextStyle(
        fontSize: 20.0,
        color: primaryColor
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText('DIGITALIZE YOUR SCHOOL...',
          speed: const Duration(milliseconds: 100),
          textStyle: const TextStyle(
            color: lWhite,
            fontWeight: FontWeight.bold
          )), 
        ],
        isRepeatingAnimation: true,
        onTap: () {
        },
      ),
    );
  }
}

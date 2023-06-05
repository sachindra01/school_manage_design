import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/helper/auth_manager.dart';
import 'package:school_management_app/app/helper/onboard.dart';
import 'package:school_management_app/chat/chat_controller/user_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
    var user = FirebaseAuth.instance.currentUser;
  final UserController _userCon = Get.put(UserController());
  final box=GetStorage();
  dynamic userRole;
  dynamic userId;
  @override
  void initState() {
    initializeSettings();
    createCount();
    getUserId();
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
  //Create Count in firebase
  createCount() async{
    Map<String, dynamic> data = {
      "countId" : "Count-ID",
      "userCount" : 0,
      "companyCount" : 0,
      "manifestCount" : 0,
      "statusCount" : 0,
      "vehicleCount" : 0,
      "chatCount":0,
      "groupchatCount":0,
      "rosterCount":0,
      "addressBookCount": 0

    };
    await FirebaseFirestore.instance
    .collection('Count')
    .limit(1) 
    .get() 
    .then((snapshot) async{
        if (snapshot.size == 0) {
            await FirebaseFirestore.instance.collection('Count').doc("Count-ID").set(data).then((value) {debugPrint("Success");});
        } else {
          return;
        }
    });
  }

  getUserId(){
    var data= _userCon.userList;
    for(int i=0;i<data.length; i++){
      if(  data[i]['email']==user!.email.toString()){
        box.write('userRole',data[i]['role']);
        box.write('firstName',data[i]['firstName']);
        box.write('lastName',data[i]['lastName']);
        box.write('phoneNumber',data[i]['phoneNumber']);
        box.write('companyName',data[i]['companyName']);
        box.write('isEnabled',data[i]['isEnabled']);
        box.write('userNote', data[i]['note']);
        box.write('profilePhoto', data[i]['profilePic']);
      }
    }
  }
}

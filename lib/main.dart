import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/app/core/theme.dart/theme.dart';
import 'package:school_management_app/app/modules/home/views/splash_screen.dart';
import 'package:school_management_app/app/core/app_translation/app%20translation.dart';
import 'package:school_management_app/app/notification_service.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   @override
  void initState() {
    super.initState();
    getPushedNotification();
    getFcmToken();
  }

  getFcmToken() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcm = await messaging.getToken();
    return fcm;
  }

  getPushedNotification(){
    //On Backgorund Message app terminated
    FirebaseMessaging.instance.getInitialMessage().then((message){
      if(message != null){
      // final routeFromNotification = message.data["route"];
      // navigatorKey.currentState!.pushNamed(routeFromNotification);
      // Navigator.pushNamed(context, routeFromNotification);
      }
    });

    //On Foreground Message
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(message.notification!.title);
      debugPrint(message.notification!.body);
        //initialize local notification
      LocalNotificationService.initialize(context);
      LocalNotificationService.display(message);

      
    });

    //On Backgorund Message
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // final routeFromNotification = message.data["route"];
      // navigatorKey.currentState!.pushNamed(routeFromNotification);
    });
  }  

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 780),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            translations: AppTranslations(),
            themeMode: ThemeMode.system,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            locale: read('lang') == "" ? Get.deviceLocale : Locale(box.read('lang')) ,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        }
    );
  }
}

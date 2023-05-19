import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/app/core/theme.dart/theme.dart';
import 'package:school_management_app/app/modules/home/views/splash_screen.dart';
import 'package:school_management_app/app/core/app_translation/app%20translation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

import 'package:animated_switch/animated_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:school_management_app/app/common/constant.dart';
import 'package:school_management_app/app/common/curved_shape.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/custom_dailogbox.dart';
import 'package:school_management_app/app/common/gradient_button.dart';
import 'package:school_management_app/app/common/profile_list.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/app/common/style.dart';

class ProfileScreen extends StatefulWidget {


   const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool _isDarkMode = true;
  bool notification = false;

  bool biometrics = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultAppbar(
          context,
          autoImplying: true,
          title: Text(
            'profile'.tr,
            style: const TextStyle(
              fontSize: 20.0,
              letterSpacing: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          action: [
             logoutButton(context)
          ]
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: HeaderCurvedContainer(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,

                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        'assets/img/person1.png',
                        height: 40.h,
                        width: 40.w,
                      )
                    ),
                  ),
                ),
              //UserName
              Text('CODENT ACADEMIC SOFTWARE'.tr),
              //User Email
              const Text('codent@gmail.com', ),
              SizedBox(height: 10.h,),
              //Edit Profile Button
              GradientButton(
                text: "editProfile".tr,
                height: 35.h,
                borderRadius: 100.r,
                onPressed: (){
                  // Get.to(()=> EditProfilePage(
                  //   userData: _authCon.userProfileData!,
                  // ));
                }
              ),
                profileMenu(),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //showing profileMenu
  profileMenu(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
              borderRadius: BorderRadius.circular(40.0),
            ),
          child: Container(
            height: 400.h,
            decoration: const BoxDecoration(
              color: lWhite
            ),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.user_shield,
                      text: 'aboutUs'.tr,
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.cog,
                      text: 'settings'.tr
                    ),
                    ProfileListItem(
                      iconWidget:  DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down,color: lWhite,),
                          borderRadius: BorderRadius.circular(0.0),
                          items: language.map<DropdownMenuItem<String>>((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val)
                            );
                          }).toList(), 
                          onChanged: (newVal) {
                              var locale = Locale(newVal == 'English' ? 'en' : 'np');
                              write('lang', newVal == 'English' ? 'en' : 'np');
                              Get.updateLocale(locale);
                                          
                          },
                        )
                      ),
                      color: primaryColor,
                      icon: LineAwesomeIcons.globe,
                      text: 'language'.tr,
                      hasNavigation: true,
                    ),
                    ProfileListItem(
                      color: primaryColor,
                      icon: LineAwesomeIcons.bell,
                      text: 'notification'.tr,
                      iconWidget: const AnimatedSwitch(    
                        height: 30,
                        textOn: "On",
                        textOff: "Off",
                        textStyle: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      hasNavigation: true,
                    ),
                    ProfileListItem(
                      color: primaryColor,
                      icon: LineAwesomeIcons.lightbulb,
                      text: 'Theme'.tr,
                      iconWidget: AnimatedSwitch(  
                        value: _isDarkMode,  
                        onChanged: (value) {
                            Get.changeThemeMode(
                              _isDarkMode ? ThemeMode.light : ThemeMode.dark,
                            );
                            setState(() {
                              _isDarkMode = !_isDarkMode;
                            });
                            write('isDarkMode', _isDarkMode);
                          },
                        height: 30,
                        textOn: "light",
                        colorOff: lBlack,
                        indicatorColor:_isDarkMode==true? white:black,
                        colorOn: lWhite,
                        textOff: "dark",
                        textStyle:TextStyle(
                          color: _isDarkMode==true? white:black, fontSize: 15),
                      ),
                      hasNavigation: true,
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.question_circle,
                      text: 'help and support'.tr
                    ),
                    
                   
                   
                  ],
                ),
                ),
        ),
      ),
    );
  }
  logoutButton(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          customDialogBox(
            context, 
            "Do you want to exit app?", 
            (){}, 
            (){},
            // (){
            //   Navigator.pop(context);
            // }
          );
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: lRed,
            border: Border.all(
              color:lRed,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(60))
          ),
          child: const Icon(LineAwesomeIcons.alternate_sign_out,),
        ),
      ),
    );
  } 
}

import 'package:animated_switch/animated_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:school_management_app/app/common/constant.dart';
import 'package:school_management_app/app/common/curved_shape.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/custom_dailogbox.dart';
import 'package:school_management_app/app/common/profile_list.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/auth/auth_contoller.dart';

class ProfileScreen extends StatefulWidget {


   const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool notification = false;

  bool biometrics = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultAppbar(
          context,
          autoImplying: false,
          leadingIcon: const SizedBox(),
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
                height: MediaQuery.of(context).size.height/0.5,
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
                        height: 30.h,
                        width: 30.w,
                      )
                    ),
                  ),
                ),
              GetBuilder(
                init: AuthController(),
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        //UserName
                    Text(read('loginInfoemail')),
                    //User Email
                    Text(read('loginInfoemail')),
                    SizedBox(height: 10.h,),
                    ],
                  );
                }
              ),
              const SizedBox(
                height: 10,
              ),
              //Edit Profile Button
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
        child: Container(
          height: 300.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
              ]
            ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.user_shield,
                    text: 'aboutUs'.tr,
                  ),
                  ProfileListItem(
                    iconWidget:  DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down,color: lWhite,),
                        borderRadius: BorderRadius.circular(0.0),
                        items: language.map<DropdownMenuItem<String>>((val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Row(
                              children: [
                               val=='English'
                               ?Padding(
                                 padding: const EdgeInsets.all(5.0),
                                 child: Image.asset('assets/img/uk.png', height: 20,width: 20),
                               )
                               :Image.asset('assets/img/nepal.png', height: 15,width: 20,),
                                Text(val),
                              ],
                            )
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
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("UserList").snapshots(),
                    builder: (context,snapshot) {
                       if (!snapshot.hasData) {
                          return  SizedBox(
                              height: MediaQuery.of(context).size.height - kToolbarHeight,
                              child: const Center(child: CircularProgressIndicator( color: Colors.black,),),
                            );
                          } else {
                            List<QueryDocumentSnapshot<Object?>> userList = snapshot.data!.docs;
                              return ProfileListItem(
                                color: primaryColor,
                                icon: LineAwesomeIcons.bell,
                                text: 'notification'.tr,
                                iconWidget:  AnimatedSwitch(  
                                  value:userList[0]["isNotification"] ?? true,  
                                    onChanged: (value) {
                                      setState(() {
                                        FirebaseFirestore.instance.collection("UserList").doc(read('userId').toString()).update(
                                          {'isNotification' : value}
                                        );
                                      });
                                    },
                                    height: 30,
                                    textOn: "on",
                                    colorOff: lRed,
                                    indicatorColor:userList[0]["isNotification"] ==true? white:black,
                                    colorOn: Colors.green,
                                    textOff: "off",
                                    textStyle:TextStyle(
                                      color:userList[0]["isNotification"] ==true? white:black, fontSize: 15),
                                 ),
                                hasNavigation: true,
                              );
                    }
   } ),
                  // ProfileListItem(
                  //   color: primaryColor,
                  //   icon: LineAwesomeIcons.lightbulb,
                  //   text: 'Theme'.tr,
                  //   iconWidget: AnimatedSwitch(  
                  //     value: _isDarkMode,  
                  //     onChanged: (value) {
                  //         Get.changeThemeMode(
                  //           _isDarkMode ? ThemeMode.light : ThemeMode.dark,
                  //         );
                  //         setState(() {
                  //           _isDarkMode = !_isDarkMode;
                  //         });
                  //         write('isDarkMode', _isDarkMode);
                  //       },
                  //     height: 30,
                  //     textOn: "light",
                  //     colorOff: lBlack,
                  //     indicatorColor:_isDarkMode==true? white:black,
                  //     colorOn: lWhite,
                  //     textOff: "dark",
                  //     textStyle:TextStyle(
                  //       color: _isDarkMode==true? white:black, fontSize: 15),
                  //   ),
                  //   hasNavigation: true,
                  // ),
                  ProfileListItem(
                    color: primaryColor,
                    icon: LineAwesomeIcons.lightbulb,
                    text: 'BioMetric'.tr,
                    iconWidget: AnimatedSwitch(  
                      value:read('biometricsEnabled')==''? false:read('biometricsEnabled'),  
                      onChanged: (value) {
                        setState(() {
                            biometrics = value;
                          });
                          write('biometricsEnabled', biometrics);
                        },
                      height: 30,
                      textOn: "on",
                      colorOff: lWhite,
                      indicatorColor:biometrics==true? white:black,
                      colorOn: black,
                      textOff: "off",
                      textStyle:TextStyle(
                        color: biometrics==true? white:black, fontSize: 15),
                    ),
                    hasNavigation: true,
                  ),
                ],
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
          );
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
              ]
            ),
          child: const Icon(LineAwesomeIcons.alternate_sign_out,color: lRed,),
        ),
      ),
    );
  } 
}

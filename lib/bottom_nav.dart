import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/home/views/home_screen.dart';
import 'package:school_management_app/app/modules/leave/leave.dart';
import 'package:school_management_app/app/modules/notification/notification_screen.dart';
import 'package:school_management_app/app/modules/profile/views/profile_screen.dart';


class BottomNavbar extends StatefulWidget {
  final int index;
  const BottomNavbar({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedIndex = 0;
  var selectedDotIndex = 0.obs;
  List <Widget> ?pages;

  @override
  void initState() {
    super.initState();
    

    pages = [
      //dashboard
       Container(),
      //profile
      const LeavePage(),
      //homPage
      const HomeScreen(),
      //Leave
       const NotificationScreen(),
      //notification
      const ProfileScreen()
    ];
    handleTap(widget.index);
  }

  handleTap(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  firstTimeDialog(){
    showDialog(context: context,
      barrierDismissible: false, 
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(15.sp),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child:Builder(
            builder: (context) {
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 15.sp,
                  ),
                  SizedBox(
                    height: 24.sp,
                  )
                ],
              );
            },
          ), 
        );
      },
    );
  }

  carouselContainer(){
    return Container(
      height: 416.sp,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.sp),
      color: primaryColor,
      child: Image.asset("assets/images/walkthrough.png",fit: BoxFit.cover, ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: lWhite,
        body: pages![selectedIndex],
        resizeToAvoidBottomInset: false,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 50.0.h),
          child: SizedBox(
            height: 76.h,
            width: 76.h,
            child: FloatingActionButton(
              onPressed: (){
                handleTap(2);
              },
              backgroundColor: white,
              foregroundColor: white,
              highlightElevation: 5,
              elevation: 0,
              child: Container(
                height: 64.h,
                width: 64.h,
                decoration: const BoxDecoration(
                  boxShadow:  [
                    BoxShadow(
                        blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
                  ],
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                   Icon(Icons.home_filled),
                    Text("Home", )
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container( 
          height: 70.0.h,
          decoration: const BoxDecoration(
             boxShadow: [
                BoxShadow(
                    blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
              ]
          ),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0.sp),
                topRight: Radius.circular(16.0.sp),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: handleTap,
                currentIndex: selectedIndex,
                elevation: 10,
                backgroundColor: white,
                iconSize: 26.0.sp,
                unselectedItemColor: lGrey2,
                selectedItemColor: primaryColor,
                selectedFontSize: 10.0.sp,
                unselectedFontSize: 10.0.sp,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom : 3.4.h),
                      child: const Icon(Icons.dashboard,),
                    ),
                    label: "Dashboard",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom : 3.4.h),
                      child: const Icon(Icons.calendar_month,),
                    ),
                    label: "Leave",
                  ),
                  const BottomNavigationBarItem(
                    icon:Icon(Icons.home),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom : 3.4.h),
                      child: const Icon(Icons.notifications,),
                    ),
                    label: "Notification",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom : 3.4.h),
                      child: CircleAvatar(
                        radius:15,
                        backgroundColor: lBlack,
                        child: Padding(
                          padding: const EdgeInsets.all(2), // Border radius
                          child:
                              ClipOval(child: Image.asset('assets/img/person1.png')),
                        ),
                      ),
                    ),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
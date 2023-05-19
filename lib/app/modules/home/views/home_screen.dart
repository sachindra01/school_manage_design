// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/carousel_slider.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/profile/views/profile_screen.dart';
import 'package:school_management_app/app/modules/unauthorise_module/feedback/feedback_screen.dart';
import 'package:school_management_app/app/modules/unauthorise_module/notice/notice_board_screen.dart';
import 'package:school_management_app/app/modules/unauthorise_module/staff_hierachy/staff_hierachy_screen.dart';



class Choice {
  const Choice({
    required this.title,
    required this.id,
    required this.image,
    required this.route,
  });
  final String title;
  final int id;
  final String image;
  final String route;
}

const List<Choice> choices = <Choice>[
  const Choice(
      title: 'Attendence',
      id: 1,
      image: 'assets/img/logo.jpg',
      route:''),
  const Choice(
      title: 'Student',
      id: 2,
      image: 'assets/img/logo.jpg',
      route: ''),
  const Choice(
      title: 'Teacher',
      id: 3,
      image: 'assets/img/logo.jpg',
      route: ''),
  const Choice(
      title: 'Leave',
      id: 4,
      image: 'assets/img/logo.jpg',
      route: ''),
      const Choice(
      title: 'Partents',
      id: 4,
      image: 'assets/img/logo.jpg',
      route: ''),
      const Choice(
      title: 'others',
      id: 4,
      image: 'assets/img/logo.jpg',
      route: ''),
       const Choice(
      title: 'others',
      id: 4,
      image: 'assets/img/logo.jpg',
      route: ''),
       const Choice(
      title: 'others',
      id: 4,
      image: 'assets/img/logo.jpg',
      route: ''),
       const Choice(
      title: 'others',
      id: 4,
      image: 'assets/img/logo.jpg',
      route: ''),
       const Choice(
      title: 'others',
      id: 4,
      image: 'assets/img/logo.jpg',
      route: ''),
       const Choice(
      title: 'others',
      id: 4,
      image: 'assets/img/logo.jpg',
      route: ''),
     

     

];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  DateTime datetime = DateTime.now();
  List properties = [];
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context,
        ontap: (){},
        title: const Text('DashBoard'),
        action: [
          InkWell(
            onTap: (){
              Get.to(()=>const ProfileScreen());
            },
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
        ],
        autoImplying: true,leadingIcon: const Icon(Icons.menu)
        ),
      body:SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          color: primaryColor,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              bannerCarouseSlider(context,200.0,350.0),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 500.h,
                decoration: const BoxDecoration(
                 borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight:  Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
              
                ),
                color: lWhite),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: menuGridView(),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  Widget menuGridView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: choices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          childAspectRatio:0.8),
      itemBuilder: (BuildContext context, int index) {
        return Card(
         shape: RoundedRectangleBorder(
            side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3.0,
          child: InkWell(
            onTap: () {
              if (choices[index].id == 4) {
                Get.to(()=>const StaffDetail());
               
              } else if (choices[index].id == 3){
                  Get.to(()=>const NoticeBoardScreen());
                
              }else{
                 Get.to(()=>const Feedbackform());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    choices[index].image,
                    height: 40,
                    width: 40,
                    
                  ),
                ),
                Expanded(
                  child: Text(
                    choices[index].title,
                    textAlign: TextAlign. left,
                    style: const TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

  

 


 

  


  


  


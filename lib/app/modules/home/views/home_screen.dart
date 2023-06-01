// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/carousel_slider.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/attendence/attendence.dart';
import 'package:school_management_app/app/modules/home/activity_screen.dart';
import 'package:school_management_app/app/modules/leave/leave.dart';
// ignore: unused_import
import 'package:school_management_app/app/modules/unauthorise_module/feedback/feedback_screen.dart';
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
        title: const Text('Home'),
        action: [
        ],
        autoImplying: true,
        leadingIcon: const SizedBox()
        ),
      body:Container(
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
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              bannerCarouseSlider(context,200.0,350.0),
              const SizedBox(
                height: 50,
              ),
              SingleChildScrollView(
                child: Container(
                   height: MediaQuery.of(context).size.height*0.5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 8, color: lBlack, offset: Offset(2, 2))
                          ]
                      ),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                        height: 40,
                      )
                    ]),
                  ),
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
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 6.0,
          childAspectRatio:0.9),
      itemBuilder: (BuildContext context, int index) {
        return Container(
           decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
                ]
            ),
          child: InkWell(
            onTap: () {
              if (choices[index].id == 1) {
                Get.to(()=>const AttendencePage());
               
              } else if (choices[index].id == 4){
                  Get.to(()=>const LeavePage());
                
              }else if (choices[index].id == 3){
                  Get.to(()=>const StaffDetail());
                
              }else if (choices[index].id == 2){
                  Get.to(()=>const ActivityScreen());
                
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

  

 


 

  


  


  


// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/constant.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/custom_calender.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/auth/auth_contoller.dart';

class Routine extends StatefulWidget {
  const Routine({super.key});

  @override
  State<Routine> createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  final AuthController _authController =Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context,
        leadingIcon: const SizedBox(
        ), title: const Text('Student Routine')),
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(15.sp),
      child:Column(
        children: [
          _buildCalendar(),
          GetBuilder(
            init: AuthController(),
            builder: (context) {
              return SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listroutine.length,
                  itemBuilder: (context, index) {
                    return Obx(()=>
                     listroutine[index]['Date']!=_authController.selectedDate.value.toString()
                     ?const SizedBox():
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      trailing: const SizedBox(),
                        backgroundColor: lWhite,
                        collapsedBackgroundColor: lWhite,
                        collapsedIconColor: primaryColor,
                        onExpansionChanged: (bool expanded){
                          setState(() {
                          //  isChecked![index] = expanded;
                          });
                        },
                        tilePadding: const EdgeInsets.only(right: 6.0, left: 5.0,top: 0.0),
                        title: Container(
                          height: 60,
                           decoration: BoxDecoration(
                            color: lGreyish,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: lGrey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  listroutine[index]['Subject'].toString(),
                                  style: const TextStyle(
                                    color:  primaryColor, 
                                    fontSize: 18.0, 
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                 'By:${listroutine[index]['Teachername']}',
                                  style: const TextStyle(
                                    color:  primaryColor, 
                                    fontSize: 18.0, 
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        leading: SizedBox(
                          width: 120,
                          child: Row(
                            children: [
                                SizedBox(
                                  child: Center(child: Text(listroutine[index]['Time'].toString())),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                              SizedBox(
                                width: 40.0,
                                child: Stack(
                                  children:  const [
                                    Center(
                                      child: DottedLine(
                                        direction: Axis.vertical,
                                        lineLength: double.infinity,
                                        lineThickness: 2.0,
                                        dashRadius: 100.0,
                                        dashColor: Colors.green,
                                        dashGapLength: 1.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      ),
                                    ),
                                     Padding(
                                       padding: EdgeInsets.only(left: 0.0),
                                       child: Center(
                                        child: DottedLine(
                                          direction: Axis.horizontal,
                                          lineLength: double.infinity,
                                          lineThickness: 2.0,
                                          dashRadius: 100.0,
                                          dashColor: Colors.green,
                                          dashGapLength: 1.0,
                                          dashGapColor: Colors.transparent,
                                          dashGapRadius: 0.0,
                                        ),
                                                             ),
                                     ),
                                    Center(
                                      child: Icon(Icons.radio_button_checked,color:Colors.green ,)
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                      )
                    )
                    );
                  
                },),
              );
            }
          ),
        ],
      )
    );
  }

 

  _buildCalendar() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.sp).copyWith(bottom: 30.sp),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
            ]
          ),
        child: const CustomCalendar(
          formatvisible: true,
          isEvent: true,
        ));
  }
}
// ignore: unused_import
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/constant.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/auth/auth_contoller.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(context),
      body: Column(
        children:  [
          const SizedBox(
            height: 60,
          ),
          const Center(
            child: SizedBox(
              height: 200,
              child: AnalogClock(
                dialColor: Colors.blueGrey
                ,
                markingColor: lWhite,
                hourNumberColor: lWhite,
                secondHandColor: lRed,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
           GetBuilder(
            init: AuthController(),
            builder: (context) {
              return SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listroutine.length,
                  itemBuilder: (context, index) {
                    return Theme(
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
                              const SizedBox(
                                width: 40.0,
                              ),
                            ],
                          ),
                        ),
                        
                      )
                    );
                },),
              );
            }
          ),
          
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/custom_calender.dart';
import 'package:school_management_app/app/common/style.dart';

class AttendencePage extends StatefulWidget {
  const AttendencePage({super.key});

  @override
  State<AttendencePage> createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: defaultAppbar(context,title: const Text('Attendence')),
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding:  EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 8.sp ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: primaryColor,
                width: 1
              )
            ),
            child: const Text("Attendence",),
          ),
          _buildCalendar(),
          _total(),
        ],
      ),
    );
  }
  _buildCalendar(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.sp).copyWith(bottom: 30.sp),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow:  const [
          BoxShadow(
            blurRadius: 8,
            color: lGrey3,
            offset: Offset(2, 2)
          )
        ]
      ),
      child: const CustomCalendar(formatvisible: true,isEvent: true,)

    );
  }

  _total(){
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           Card(
            color:Colors.green,
           shape: RoundedRectangleBorder(
              side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3.0,
            child: InkWell(
              onTap: () {
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                     'TOTAL Present :9 days',
                      textAlign: TextAlign. left,
                      style: TextStyle(
                          fontSize: 16,
                          color: lWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.red,
           shape: RoundedRectangleBorder(
              side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3.0,
            child: InkWell(
              onTap: () {
               
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                     'TOTAL Absent :9 days',
                      textAlign: TextAlign. left,
                      style: TextStyle(
                          fontSize: 16,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
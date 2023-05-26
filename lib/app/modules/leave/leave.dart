// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/custom_calender.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/leave/add_leave_page.dart';
import 'package:school_management_app/app/modules/leave/applied_leave_menu.dart';
import 'package:school_management_app/app/modules/leave/widget/leave_tile.dart';
import 'package:school_management_app/app/modules/leave/widget/remaining_leaveTile.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
        onTap: (){
          Get.to(()=>const LeaveForm());
        },
        child: Container(
            decoration: BoxDecoration(
               gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(220, 46, 36, 72),
                  // Color.fromARGB(255, 230, 149, 45),
                  Color.fromARGB(255, 223, 104, 144),
                    ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
            border: Border.all(
              color:greyColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(60))
          ),
          height: 60,
          width: 60,
          child: const Icon(Icons.add,color: lWhite,size: 25,)),
      ),
      appBar: defaultAppbar(
        context,
        leadingIcon: const SizedBox(
        ), title: const Text('Leave')),
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 8.sp),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "Leave",
            ),
          ),
          _buildCalendar(),
          _buildleaveList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Applied Leave',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const AppliedLeaveList());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.sp, vertical: 8.sp),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 8,
                            color: primaryColor,
                            offset: Offset(2, 2))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "See All",
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildAllleaveLists(),
        ],
      ),
    );
  }

  _buildleaveList() {
    return const LeaveRemaining();
  }

  _buildAllleaveLists() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return const LeaveTile(
          aprrovedTitle: 'hello',
        );
      },
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
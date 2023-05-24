import 'package:flutter/material.dart';
import 'package:school_management_app/app/modules/leave/all_leave_design.dart';

class CasualLeavePage extends StatefulWidget {
  const CasualLeavePage({super.key});

  @override
  State<CasualLeavePage> createState() => _CasualLeavePageState();
}

class _CasualLeavePageState extends State<CasualLeavePage> {

  String month='November';
  String date='WEd,10';
  String description='';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
           physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const LeaveTile(
              aprrovedTitle: 'Approved',
              date: 'WED,10',
              leaveType: 'Full day',
              monthTitle: 'November',
              reasontitle: 'Sick',
            );
          },
        ),
      )

    );
    
  }
}
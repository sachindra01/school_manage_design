import 'package:flutter/material.dart';
import 'package:school_management_app/app/modules/leave/widget/leave_tile.dart';

class CasualLeavePage extends StatefulWidget {
  const CasualLeavePage({super.key});

  @override
  State<CasualLeavePage> createState() => _CasualLeavePageState();
}

class _CasualLeavePageState extends State<CasualLeavePage> {
  String month = 'November';
  String date = 'WEd,10';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(5.0),
              child: LeaveTile(
                aprrovedTitle: 'Approved',
                date: 'WED,10',
                leaveType: 'Full day',
                monthTitle: 'November',
                reasontitle: 'Sick',
              ),
            );
          },
        ));
  }
}
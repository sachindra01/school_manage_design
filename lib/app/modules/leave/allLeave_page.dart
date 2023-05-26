// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:school_management_app/app/modules/leave/widget/leave_tile.dart';

class AllLeavePage extends StatefulWidget {
  const AllLeavePage({super.key});

  @override
  State<AllLeavePage> createState() => _AllLeavePageState();
}

class _AllLeavePageState extends State<AllLeavePage> {
  String month = 'November';
  String date = 'WEd,10';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
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
    ));
  }
}
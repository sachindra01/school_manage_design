// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/style.dart';

class LeaveTile extends StatelessWidget {
  final String? monthTitle;
  final String? reasontitle;
  final String? leaveType;
  final String? date;
  final String? aprrovedTitle;
  const LeaveTile({
    super.key,
    this.monthTitle,
    this.reasontitle,
    this.date,
    this.aprrovedTitle,
    this.leaveType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
            ]
          ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
             decoration: BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5, color: primaryColor, offset: Offset(2, 2))
            ]
          ),
              height: 40,
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('01/23/2023'),
                SizedBox(
                  height: 10,
                ),
                Text('Casual Leave'),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, // Change color of the shadow
                      blurRadius: 0.0,
                      spreadRadius: 0.1,
                      offset: Offset(0.2, 0.2))
                ],
                borderRadius:
                    BorderRadius.circular(40), // <= No more error here :)
                color: lGrey,
              ),
              child: const Icon(
                Icons.check,
                color: primaryColor,
                size: 20,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
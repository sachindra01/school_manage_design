// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_app/app/common/style.dart';

class LeaveRemaining extends StatelessWidget {
  const LeaveRemaining({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Leave Remaining',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
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
                "See All",
              ),
            ),
          ],
        ),
        Container(
            margin:
                EdgeInsets.symmetric(vertical: 10.sp).copyWith(bottom: 30.sp),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
                ]),
            height: 120.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: lRed, width: 2.0),
                              color:
                                  Colors.grey.withOpacity(0.25), // border color
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2), // border width
                              child: Container(
                                // or ClipRRect if you need to clip the content
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle, // inner circle color
                                ),
                                child: const Center(
                                  child: Text('15/20'),
                                ), // inner content
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Casual Leave'),
                        )
                      ],
                    );
                  })),
            )),
      ],
    );
  }
}
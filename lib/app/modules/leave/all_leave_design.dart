import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_app/app/common/style.dart';

class LeaveTile extends StatelessWidget {
  final String ?monthTitle;
  final String ?reasontitle;
  final String ?leaveType;
  final String ?date;
  final String ?aprrovedTitle;
  const LeaveTile({super.key, this.monthTitle, this.reasontitle, this.date, this.aprrovedTitle, this.leaveType, });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(monthTitle.toString() ,
          style: const TextStyle(
            color:  lGrey4, 
            fontSize: 18.0, 
            fontWeight: FontWeight.w700
          ),
          ),
        ),
        Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
             decoration: const BoxDecoration(
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight:  Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                  color: lWhite
              ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(leaveType.toString() ,
                        style: const TextStyle(
                          color:  lGrey2, 
                            fontSize: 12.0, 
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Container(
                        width: 60,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey, // Change color of the shadow
                                  blurRadius: 0.0,
                                  spreadRadius: 0.1,
                                  offset: Offset(0.2, 0.2)
                                )
                            ],
                            borderRadius: BorderRadius.circular(10), // <= No more error here :)
                            color: primaryColor,
                            ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0,right: 5.0,top: 2.0,bottom: 2.0),
                          child: Text(aprrovedTitle.toString(),
                            style: const TextStyle(
                              color:  lWhite, 
                              fontSize: 12.0, 
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                   Text(date.toString() ,
                      style: const TextStyle(
                        color:  primaryColor, 
                        fontSize: 18.0, 
                        fontWeight: FontWeight.w700
                      ),
                    ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(reasontitle.toString(),
                       style: const TextStyle(
                          color:  lGrey2, 
                          fontSize: 12.0, 
                          fontWeight: FontWeight.w500
                        ),
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
                                  offset: Offset(0.2, 0.2)
                                )
                            ],
                            borderRadius: BorderRadius.circular(10), // <= No more error here :)
                            color: lGrey,
                            ),
                            child: const Icon(Icons.arrow_forward_ios,color: primaryColor,size: 15,),
                      ),
                    ],
                  ),

                
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
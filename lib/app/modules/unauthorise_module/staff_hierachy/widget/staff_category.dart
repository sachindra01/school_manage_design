import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:school_management_app/app/common/style.dart';

class StaffCategoryTile extends StatefulWidget {
  final String? categoryName;
  // ignore: prefer_typing_uninitialized_variables
  final image, checkBoxColor, checkBoxBorderCol, textColor;
  final Widget? checkbox;
  final VoidCallback? onTap;
  const StaffCategoryTile(
      {Key? key,
      this.categoryName,
      this.image,
      this.onTap,
      this.checkBoxColor,
      this.textColor,
      this.checkBoxBorderCol, this.checkbox})
      : super(key: key);

  @override
  State<StaffCategoryTile> createState() => _StaffCategoryTileState();
}

class _StaffCategoryTileState extends State<StaffCategoryTile> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 29.0),
          height: 50,
          color: lWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
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
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 50.0,
                child: Stack(
                  children: const [
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
                         Align(
                      alignment:Alignment.centerLeft,
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
                        child: Icon(Icons.radio_button_checked,color:Colors.green ,size: 18,)
                      )
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child:   Container(
                  width:  60,
                  height: 60,
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        'assets/img/person1.png',
                        height: 40.h,
                        width: 40.w,
                      )
                    ),
                  ),
                ),
              ),
              Text(
                widget.categoryName!.tr,
                style: TextStyle(
                    fontSize: 16.0,
                    color: widget.textColor,
                    fontWeight: FontWeight.w700),
              ),
              Center(child: widget.checkbox)
            ],
          ),
        ),
      ),
    );
  }
}
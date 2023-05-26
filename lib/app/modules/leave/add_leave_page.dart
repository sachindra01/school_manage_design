import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/custom_textfield.dart';
import 'package:school_management_app/app/common/gradient_button.dart';
import 'package:school_management_app/app/common/style.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class LeaveForm extends StatefulWidget {
  const LeaveForm({super.key});

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final TextEditingController leaveCategoryController = TextEditingController();
  final TextEditingController leaveDaysController = TextEditingController();
  final TextEditingController noOfDaysController = TextEditingController();
  final TextEditingController leaveReason = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  final TextEditingController approverName = TextEditingController();
  List approver = [];
  //bool check for checkbox
  bool isAD = true;
  bool isBS = false;
  String finalFromDateInAD = "";
  String finalFromDateInBS = "";
  String finalToDateInAD = "";
  String finalToDateInBS = "";

  //To calculate no.of days from from and to date
  dynamic calcFromDate = "";
  dynamic calcToDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(context, title: const Text("Add Leave")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextDropdownFormField(
              //   onChanged: (item) {
              //     setState(() {
              //       approver.add(item.toString());
              //       if (kDebugMode) {
              //         print(item);
              //       }
              //     });
              //   },
              //   options: const ["sachindra", "nitin"],
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       suffixIcon: Icon(Icons.arrow_drop_down),
              //       labelText: "select Approver"),
              //   dropdownHeight: 120,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // chipdesign(),
              // const SizedBox(
              //   height: 16,
              // ),
              const Text('Subject'),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(context: context, controller: subject),
              SizedBox(
                height: 16.h,
              ),
              const Text('Leave category'),
              const SizedBox(
                height: 10,
              ),
              TextDropdownFormField(
                onChanged: (item) {},
                options: const ["Annual Leave", "casual leave", "Sick Leave"],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText: "select LeaveType"),
                dropdownHeight: 120,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Leave Day'),
              const SizedBox(
                height: 10,
              ),
              TextDropdownFormField(
                onChanged: (item) {},
                options: const ["Full day", "half day"],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText: "select LeaveType"),
                dropdownHeight: 120,
              ),
              SizedBox(
                height: 16.h,
              ),
              selectDateType(),
              SizedBox(
                height: 10.h,
              ),
              fromAndToDate(context),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "No. of Days:",
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    noOfDaysController.text,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  const Text(
                    "days",
                  ),
                ],
              ),
              SizedBox(
                height: 22.h,
              ),
              InkWell(
                  onTap: () {
                    pickDate("from", convertedDate(fromDate.text));
                  },
                  child: const Text('Leave Reason')),
              SizedBox(
                height: 22.h,
              ),
              //Leave Reason
              leavesReason(),
              SizedBox(
                height: 22.h,
              ),
              Center(
                child: GradientButton(
                    text: "Submit".tr,
                    height: 40.h,
                    width: 200.w,
                    borderRadius: 100.r,
                    onPressed: () async {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  leavesReason() {
    return TextFormField(
      onEditingComplete: () {},
      controller: leaveReason,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      maxLines: 10,
    );
  }

  //Select Date type (AD/ BS)
  selectDateType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            //For AD
            Checkbox(
                activeColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 1, color: Colors.pink),
                ),
                value: isAD,
                onChanged: (val) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    isBS = false;
                    isAD = true;
                    //Set to and from date
                    if (finalFromDateInAD != "" && finalFromDateInBS != "") {
                      fromDate.text = finalFromDateInAD;
                    }
                    if (finalToDateInAD != "" && finalToDateInBS != "") {
                      toDate.text = finalToDateInAD;
                    }
                    // finalFromDateInAD = "";
                    // finalToDateInAD = "";
                    // fromDate.clear;
                    // fromDate.text = "";
                    // toDate.clear;
                    // toDate.text = "";
                  });
                }),
            const Text(
              "A.D",
            ),
            SizedBox(
              width: 16.w,
            ),
            //For BS
            Checkbox(
                activeColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 1, color: Colors.pink),
                ),
                value: isBS,
                onChanged: (val) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    isAD = false;
                    isBS = true;
                    //Set to and from date
                    if (finalFromDateInAD != "" && finalFromDateInBS != "") {
                      fromDate.text = finalFromDateInBS;
                    }
                    if (finalToDateInAD != "" && finalToDateInBS != "") {
                      toDate.text = finalToDateInBS;
                    }
                    // finalFromDateInAD = "";
                    // finalToDateInAD = "";
                    // fromDate.clear;
                    // fromDate.text = "";
                    // toDate.clear;
                    // toDate.text = "";
                  });
                }),
            const Text(
              "B.S",
            ),
          ],
        )
      ],
    );
  }

  //From and to Date
  fromAndToDate(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //From
        SizedBox(
          width: 160,
          child: CustomTextField(
            context: context,
            readonly: true,
            controller: fromDate,
            keyboardType: TextInputType.number,
            labelText: "from".tr,
            suffixIcon: InkWell(
                onTap: () {
                  pickDate("from", convertedDate(fromDate.text));
                },
                child: const Icon(
                  Icons.calendar_month,
                  color: Colors.pink,
                )),
            validator: (fromDate) {
              return fromDate == null || fromDate.isEmpty
                  ? 'From Date cannot be empty.'
                  : null;
            },
          ),
        ),
        //To
        SizedBox(
          width: 160,
          child: InkWell(
            onTap: () {
              pickDate("to", convertedDate(toDate.text));
            },
            child: CustomTextField(
              readonly: true,
              controller: toDate,
              keyboardType: TextInputType.number,
              labelText: "to".tr,
              suffixIcon: InkWell(
                  onTap: () {
                    pickDate("to", convertedDate(toDate.text));
                  },
                  child: const Icon(
                    Icons.calendar_month,
                    color: Colors.pink,
                  )),
              context: context,
            ),
          ),
        ),
      ],
    );
  }

  //Date Picker English
  pickDate(type, initialDate) async {
    //-----For Selecting Date in AD-----
    if (isAD) {
      //Pick Eng Date
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(
            1900), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(3000),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: lRed.withOpacity(0.9), //Background color
                onSurface:
                    Get.isDarkMode ? white : black, //UnSelected Date Font Color
              ),
            ),
            child: child!,
          );
        },
      );
      //Formatt date
      if (pickedDate != null) {
        //Formatted Eng Date
        var englishDateTime =
            DateTime(pickedDate.year, pickedDate.month, pickedDate.day)
                .toString();
        //Formatted Nep Date
        var nepaliDate =
            DateTime(pickedDate.year, pickedDate.month, pickedDate.day)
                .toNepaliDateTime();
        if (type == "from") {
          //Set the latest Calc date for calcuation
          calcFromDate = DateTime.parse(englishDateTime);
          //if we have to date then calculate the total no of days
          if (calcToDate != "") {
            noOfDaysController.text = formatDate(calcFromDate, calcToDate);
          }
          //set fromDate text controller
          fromDate.text = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(englishDateTime)))
              .toString();
          //store date to send to api
          finalFromDateInAD = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(englishDateTime)))
              .toString();
          finalFromDateInBS = NepaliDateFormat('yyyy-MM-dd')
              .format((NepaliDateTime.parse(nepaliDate.toString())))
              .toString();
          //set date for calculation
          calcFromDate = DateTime.parse(englishDateTime);
        } else {
          //Set the latest Calc date for calcuation
          calcToDate = DateTime.parse(englishDateTime);
          //if we have from date then calculate the total no of days
          if (calcFromDate != "") {
            noOfDaysController.text = formatDate(calcFromDate, calcToDate);
          }
          //set ToDate text controller
          toDate.text = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(englishDateTime)))
              .toString();
          //store date to send to api
          finalToDateInAD = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(englishDateTime)))
              .toString();
          finalToDateInBS = NepaliDateFormat('yyyy-MM-dd')
              .format((NepaliDateTime.parse(nepaliDate.toString())))
              .toString();
          //set date for calculation
          calcToDate = DateTime.parse(englishDateTime);
        }
        // var nepDateInString = NepaliDateFormat('yyyy-MM-dd').format((NepaliDateTime.parse(nepaliDate.toString()))).toString();
      }
    }
    //For Selecting Date in BS
    else {
      //Pick Nep Date
      DateTime? pickedDate = await picker.showMaterialDatePicker(
        context: context,
        initialDate: initialDate != null
            ? NepaliDateTime(
                initialDate.year, initialDate.month, initialDate.day)
            : NepaliDateTime.now(),
        firstDate: NepaliDateTime(2000),
        lastDate: NepaliDateTime(2090),
        initialDatePickerMode: DatePickerMode.day,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: lRed.withOpacity(0.9), //Background color
                onSurface:
                    Get.isDarkMode ? white : black, //UnSelected Date Font Color
              ),
            ),
            child: child!,
          );
        },
      );
      //Format Nepali date
      if (pickedDate != null) {
        //Formatt date in BS
        var formattedDateTime =
            DateTime(pickedDate.year, pickedDate.month, pickedDate.day)
                .toString();
        //Formatt date in AD
        var engDate = NepaliDateTime(
                pickedDate.year, pickedDate.month, pickedDate.day, 0, 0, 0)
            .toDateTime();
        if (type == "from") {
          //if we have to date then calculate the total no of days
          if (calcToDate != "") {
            noOfDaysController.text = formatDate(calcFromDate, calcToDate);
          }
          //set fromDate text controller
          fromDate.text = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(formattedDateTime)))
              .toString();
          //store date to send to api
          finalFromDateInAD = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(engDate.toString())))
              .toString();
          finalFromDateInBS = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(formattedDateTime)))
              .toString();
          //set date for calculation
          calcFromDate = DateTime.parse(engDate.toString());
        } else {
          //if we have to date then calculate the total no of days
          calcToDate = DateTime.parse(engDate.toString());
          if (calcFromDate != "") {
            noOfDaysController.text = formatDate(calcFromDate, calcToDate);
          }
          //set ToDate text controller
          toDate.text = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(formattedDateTime)))
              .toString();
          //store date to send to api
          finalToDateInAD = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(engDate.toString())))
              .toString();
          finalToDateInBS = DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(formattedDateTime)))
              .toString();
          //set date for calculation
          calcFromDate = DateTime.parse(engDate.toString());
        }
        // var nepDateInString = NepaliDateFormat('yyyy-MM-dd').format((NepaliDateTime.parse(nepaliDate.toString()))).toString();
      }
    }

    //If only from date is selected
    if (fromDate.text != "" && toDate.text == "") {
      noOfDaysController.text = "1";
    }
    setState(() {});
  }

  //Format Date
  String formatDate(DateTime fromDate, toDate) {
    if (fromDate == toDate) {
      return "1";
    } else {
      final difference = toDate.difference(fromDate).inDays;
      if (difference < 0) {
        return "0";
      }
      return (difference + 1).toString();
    }
  }

//ConvertDate
  convertedDate(date) {
    if (date != null && date != "") {
      var splitDate = date.toString().split("-");
      var convertedDate = DateTime(int.parse(splitDate[0]),
          int.parse(splitDate[1]), int.parse(splitDate[2]));
      return convertedDate;
    } else {
      return null;
    }
  }

  chipdesign() {
    return Wrap(
        spacing: 4.w,
        runSpacing: 6.h,
        alignment: WrapAlignment.start,
        children: List.generate(
          approver.length,
          (index) => Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 5.h, right: 4.w),
                  height: 46.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.sp, vertical: 4.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 1.2.sp),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.r),
                        bottomLeft: Radius.circular(100.r),
                        bottomRight: Radius.circular(100.r)),
                  ),
                  child: Wrap(
                    // spacing: 0.1.w,
                    // runSpacing: 1.h,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    alignment: WrapAlignment.start,
                    children: [
                      //Approver Image
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5.h),
                        height: 30.h,
                        width: 30.h,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/noProfileImg.jpg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      //Approver name
                      Padding(
                        padding: EdgeInsets.only(top: 2.4.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.5.h),
                            const Text(''),
                            const Text(''),
                          ],
                        ),
                      ),
                    ],
                  )),
              //Remove Approver
              GestureDetector(
                onTap: () {
                  setState(() {
                    // approverIdList.removeAt(index);
                    // addApproverNameChip.removeAt(index);
                  });
                },
                child: Container(
                  height: 17.h,
                  width: 17.h,
                  decoration: BoxDecoration(
                    color: black,
                    border: Border.all(color: greyColor, width: 1.5.sp),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.clear,
                    size: 8.sp,
                    color: white,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/leave/add_leave_page.dart';
import 'package:school_management_app/app/modules/leave/all_leave_page.dart';
import 'package:school_management_app/app/modules/leave/casual_leave.dart';
import 'package:school_management_app/app/modules/leave/sick_leave.dart';

class LeavePage extends StatefulWidget {
  static const routeName = '/newslist';
  const LeavePage({
    Key? key,
  }) : super(key: key);

  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: (){
          Get.to(()=>const LeaveForm());
        },
        child: Container(
            decoration: BoxDecoration(
            color: primaryColor,
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
          title: const Text(
            'Leave',
            style: TextStyle(color: lWhite, fontWeight: FontWeight.bold),
          ),
          action: [
            
          ],
          autoImplying: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 45,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(
                  5.0,
                ),
              ),
              child: TabBar(

                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    7.0,
                  ),
                  color: Colors.white,
                ),
                labelColor: const Color(0xff8d6b4f),
                unselectedLabelColor: const Color(0xff8d6b4f),
                tabs: const [
                  Tab(
                    text: 'All',
                    height: 30,
                  ),
                  Tab(
                    text: 'Casual',
                    height: 30,
                  ),
                  Tab(
                    text: 'Sick',
                    height: 30,
                  ),
                ],
              ),
            ),
            // tab bar view here
            Flexible(
       
              child: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                // ignore: prefer_const_constructors
                children: const [
                AllLeavePage(),
                CasualLeavePage(),
                SickLeavePage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/leave/all_leave_page.dart';
import 'package:school_management_app/app/modules/leave/casual_leave.dart';
import 'package:school_management_app/app/modules/leave/sick_leave.dart';

class AppliedLeaveList extends StatefulWidget {
  const AppliedLeaveList({super.key});

  @override
  State<AppliedLeaveList> createState() => _AppliedLeaveListState();
}

class _AppliedLeaveListState extends State<AppliedLeaveList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late List data;

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
      appBar: defaultAppbar(context, title: const Text('All Leave Applied')),
      body: oldDesign(),
    );
  }

  oldDesign() {
    return Column(
      children: [
        // give the tab bar a height [can change hheight to preferred height]
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 8, color: lGrey, offset: Offset(2, 2))
              ],
               gradient: const LinearGradient(
                  // colors: [Colors.deepPurple, Colors.purple],
                  // begin: Alignment.topCenter,
                  // end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(220, 46, 36, 72),
                  // Color.fromARGB(255, 230, 149, 45),
                  Color.fromARGB(255, 223, 104, 144),
                    ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
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
              labelColor: primaryColor,
              unselectedLabelColor: lWhite,
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
        )
      ],
    );
  }
}
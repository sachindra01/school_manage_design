import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/unauthorise_module/notice/widget/notice_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String title = 'FirstTerminal Exam';
  String images =
      'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png';
  String description =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industryThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultAppbar(
          context,
          leadingIcon: const SizedBox(),
          title: const Text(
            'Notification',
            style: TextStyle(
                color: lWhite, fontSize: 22.0, fontWeight: FontWeight.w700),
          ),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 5.h,
            );
          },
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: NoticeTile(
                title: title,
                descrption: description,
                images: images,
                time: '59 min Ago',
              ),
            );
          },
        ));
  }
}
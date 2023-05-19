import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/unauthorise_module/notice/widget/notice_tile.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {

  String title='FirstTerminal Exam';
  String images='https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png';
  String description='Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industryThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: defaultAppbar(
        context,
        title: const Text(
          'Notice Board',
          style: TextStyle(
            color:  lWhite, 
            fontSize: 22.0, 
            fontWeight: FontWeight.w700
          ),
        ),
     ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
           physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return NoticeTile(
              title: title,
              descrption: description,
              images: images,
              time: '59 min Ago',
            );
      
          },
        ),
      )

    );
    
  }
}
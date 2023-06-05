// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';
import 'package:school_management_app/chat/group_chat_room/group_chat_page.dart';
import 'package:school_management_app/chat/widget/counter_badge.dart';


class GroupChatTile extends StatelessWidget {
  const GroupChatTile({super.key, this.data, this.id, this.chatController, this.userId, required this.groupMember, this.type,  });
  final dynamic data;
  final dynamic id;
  final dynamic userId;
  final dynamic type;
  final dynamic chatController;
  final List groupMember;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        FirebaseChatServices.groupChatlog(userId:userId,groupId: data['id']);
        Get.to(() =>  GroupChatPage(
          userName:data["group_name"].toString(),
          id:int.parse(data["id"]),
          userId:userId,
          groupMember: data["group_member"],
          profilePhoto: '',
        ));
      },
      child: Container(
        height: 80,    
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.white
        ),
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        child: Row(
          children: [
            Text(data["group_name"].toString(),  
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            CounterBadge(id: data['id'],userId: userId,)
          ],
        ),
      ),
    );
  }
}
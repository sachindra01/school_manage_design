import 'package:flutter/material.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';
import 'package:school_management_app/chat/group_chat_room/group_list_tile.dart';


class GroupUserList extends StatelessWidget {
  const GroupUserList({super.key, this.data, this.id, this.chatController, this.userId});
  final dynamic data;
  final dynamic id;
  final dynamic userId;
  final dynamic chatController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         //reset counter on tap
        FirebaseChatServices.updateCounter(
            chatController.createdocId(   
           data["userId"],id
            ),
           data["userId"]
          );
      },
      child: GroupListTile (
        id:data["userId"],
        userId:id ,
        // onTap: () {
    
        //  
          
        //   // Get.to(() =>  ChatPage(
        //   //   userName:data["firstName"].toString(),
        //   //   id:data["userId"],
        //   //   userId:userId,
        //   // ));
        // },
        name:data["userName"].toString(),
        role:data["role"].toString(),
        numberOfMessage: 2,
      ),
    );
  }
}
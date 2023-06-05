import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/chat/single_chat_room/chat_page.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';

import '../widget/chat_list_tile.dart';

class ChatTile extends StatelessWidget {
   ChatTile({super.key, this.data, this.id, this.chatController, this.userId});
  final dynamic data;
  final dynamic id;
  final dynamic userId;
  final dynamic chatController;
  final ChatController _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return ChatListTile(
      profilePhoto: data["profilePic"],
      id:data["userId"],
      userId:userId ,
      onTap: () {
        //reset counter on tap
        FirebaseChatServices.updateCounter(
          chatController.createdocId(
         data["userId"],userId
          ),
         data["userId"]
        );
        _chatController.pickedImage='';
        Get.to(() =>  ChatPage(
          profilePhoto: data["profilePic"],
          userName:data["userName"],
          id:data["userId"],
          userId:userId,
        ));
      },
      name:data["userName"],
      role:data["role"].toString(),
      numberOfMessage: 2,
    );
  
  }
}
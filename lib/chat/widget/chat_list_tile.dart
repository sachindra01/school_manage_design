// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';


class ChatListTile extends StatefulWidget {
  final VoidCallback? onTap;
  final String name;
  final String profilePhoto;
  final String? role;
  final String ?type;
  final int? numberOfMessage;
  final int? id,userId;
  const ChatListTile({super.key, this.onTap, required this.name,  this.role, this.numberOfMessage, this.id, this.userId,  this.type, required this.profilePhoto});

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  final ChatController _chatController =Get.put(ChatController());
  final box = GetStorage();
  var userId;
  var dId;
  bool showCounter = false;

  @override
  void initState() {
  initalize();
    super.initState();
  }
  initalize()async{
    setState(() {
     dId =_chatController.createdocId(
        widget.id,widget.userId
      );
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8, color: primaryColor, offset: Offset(2, 2)
            )
          ]
        ),
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.00),
              child: widget.profilePhoto == ""
              ? Image.asset(
                "assets/img/person1.png",
                height: kIsWeb
                  ? MediaQuery.of(context).size.height * 0.08
                  : MediaQuery.of(context).size.height * 0.05,
                width:  kIsWeb 
                  ? MediaQuery.of(context).size.width * 0.05
                  : MediaQuery.of(context).size.height * 0.05,
                fit: BoxFit.cover,
              )
              : Image.network(
                 widget.profilePhoto.toString(),
                height: kIsWeb
                  ? MediaQuery.of(context).size.height * 0.08
                  : MediaQuery.of(context).size.height * 0.05,
                width:  kIsWeb 
                  ? MediaQuery.of(context).size.width * 0.05
                  : MediaQuery.of(context).size.height * 0.05,
              )
            ),
            const SizedBox(width: 12,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(widget.name,  
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Spacer(),
            widget.type=='GroupChat'
            ? const SizedBox()
            : StreamBuilder(
              stream:  FirebaseChatServices.getcountDetail(dId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } 
                else{
                  var splitDoc = snapshot.data.id!.split('-');
                  var split1 = splitDoc[0];
                  var split2 = splitDoc[1];
                  String name1 = '${splitDoc[0]}_unread_count';
                  String name2 = '${splitDoc[1]}_unread_count';
                  dynamic check;
                  if(snapshot.data.data()==null){
                    check =false;
                  }
                  else{
                    check = snapshot.data.data()!.containsKey(name1); 
                  }
                  return check
                  ? StreamBuilder(
                    stream: FirebaseChatServices.getCounter(dId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                      return  const SizedBox(
                      );
                      } else {
                        var splitDoc = snapshot.data.id!.split('-');
                        var split1 =splitDoc[0];
                        var split2 =splitDoc[1];
                        String name1 = '${splitDoc[0]}_unread_count';
                        String name2 = '${splitDoc[1]}_unread_count';
                        var counter='0'; 
                        if(split1==widget.id.toString()){
                          counter = snapshot.data[name2].toString();
                        }
                        else{
                          counter = snapshot.data[name1].toString();
                        }
                        return counter != '0'
                        ?ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 28,
                            width: 28,
                            color: Colors.red,
                            child:  Center(
                              child: 
                              Text(
                                counter,
                                style: const TextStyle(fontSize: 18, color: Colors.white,),
                                textAlign:TextAlign.center,
                              )
                            ),
                          ),
                        )
                        :const SizedBox();
                      }
                    }
                  )
                  : const SizedBox();
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
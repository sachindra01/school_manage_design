import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_management_app/chat/group_chat_room/add_group_chat.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';
import 'package:school_management_app/chat/group_chat_room/group_chatTile.dart';


class GroupChatListPage extends StatefulWidget {
  const GroupChatListPage({super.key, this.userId, this.type});
  final int ?userId;
  final String ?type;
  @override
  State<GroupChatListPage> createState() => _GroupChatListPageState();
}

class _GroupChatListPageState extends State<GroupChatListPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final ChatController _chatController =Get.put(ChatController());
  dynamic userId;
  dynamic userRole;
  dynamic dId;
  dynamic userEmail;
    final box =GetStorage();
  @override
  void initState() {
    intialized();
    super.initState();
  }
  intialized(){
    setState(() {
     userId=box.read('userId');
     userRole=box.read('userRole');
     userEmail = box.read('userEmail');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: appbar(),
      // appBar: customAppbar(const Text("Chats"), true),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffF5F5F5),
          padding: const EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 0.0),
          child: StreamBuilder(
          stream: FirebaseChatServices.getgroupChatlist(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return  SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: const Center(child: CircularProgressIndicator( color: Colors.black,),),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: const Center(child: CircularProgressIndicator( color: Colors.black,),),
              );
            } else {
             //Data from firebase
             List<QueryDocumentSnapshot<Object?>> userList = snapshot.data!.docs;
              return ListView.builder(
                  itemCount :userList.length,
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    if(userList[index]['group_member'].contains( box.read('userId').toString())){
                      return GroupChatTile(
                        data: userList[index],
                        type: widget.type,
                        id: widget.userId,
                        chatController: _chatController,
                        userId: box.read('userId'),
                        groupMember: userList[index]['group_member'] ,
                      );
                    }else{
                      return const SizedBox();
                    }
                  },
                );
              }
            }
          )
        ),
      ),
    );
  } 
  appbar(){
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      actions:[
        InkWell(
          onTap: () {
            _chatController.addUser.clear();
            _chatController.addUser.add(box.read("userId").toString());
            Get.to(()=>const AddGroupChat());
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.add,color: Colors.black,),
          ),
        )
      ],
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  //  FirebaseChatServices.updateCounter(
                  //   _chatController.createdocId(
                  //    widget.id,widget.userId
                  //   ),
                  //   widget.id!.toInt()
                  // );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back,color: Colors.black,),
              ),
              const SizedBox(width: 2,),
              // ignore: prefer_const_constructors
              Expanded(
                child: const Text("Group chat",style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


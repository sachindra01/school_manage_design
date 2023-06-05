import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/chat/single_chat_room/chat_list_tile.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';
import 'package:school_management_app/chat/firebase_services/firestore_services.dart';
import 'package:school_management_app/chat/group_chat_room/group_chat_list.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key, this.userId});
  final int ?userId;
  @override
  State<ChatListPage> createState() => _ChatListPageState(  );
}

class _ChatListPageState extends State<ChatListPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final ChatController _chatController =Get.put(ChatController());
  final nameHolder = TextEditingController();
   clearTextInput() {
    nameHolder.clear();
  }
   String name = "";
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
      appBar: defaultAppbar(context,title: const Text('Chat'),
      action: [
        //will not implemented for the first Phase
        //  TextButton(
        //   onPressed:(){
        //     Get.to(()=>const GroupChatListPage(
        //       type: 'GroupChat',
        //     ));
        //   },
        //   child: const Text('Group chat',style: TextStyle(
        //   color: lWhite,
        //   fontSize: 16.0
        //   ),)
        // )

      ]
      
      ),      // appBar: customAppbar(const Text("Chats"), true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 235, 235),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  controller: nameHolder,
                  autofocus: false,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 46, 46, 46),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Color.fromARGB(185, 44, 44, 44),
                        ),
                        onPressed: clearTextInput,
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            userList()
          ],
        ),
      ),
    );
  } 

  userList(){
    return Container(
      color: const Color(0xffF5F5F5),
      child: StreamBuilder(
      stream: FirestoresServices.getUserlist(),
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
                dynamic conditionedTile;
                if(userList[index]["email"].toString() != read('loginInfoemail'))
                {
                  if(userList[index]['userName'].contains(name.capitalize)){
                    conditionedTile = ChatTile(
                      data: userList[index],
                      id: userList[index]["userId"],
                      chatController: _chatController,
                      userId: read('userId'),
                      );
                  return conditionedTile ?? const SizedBox();
                    
                  }
                }
                else{
                  return const SizedBox();
                }
                return  const SizedBox();
              },
            );
          }
        }
      )
    );

  }


  appbar(){
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      actions:[
        TextButton(
          onPressed:(){
            Get.to(()=>const GroupChatListPage(
              type: 'GroupChat',
            ));
          },
          child: const Text('Group chat',style: TextStyle(
          color: Colors.black,
          fontSize: 16.0
          ),)
        )
      ],
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 18),
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
              const Expanded(
                child: Text("Chat",style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


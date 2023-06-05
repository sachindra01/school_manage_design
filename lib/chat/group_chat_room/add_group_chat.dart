import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_management_app/app/common/loading_widget.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';
import 'package:school_management_app/chat/firebase_services/firestore_services.dart';
import 'package:school_management_app/chat/group_chat_room/group_user_list.dart';
import 'package:school_management_app/chat/chat_controller/main_controller.dart';
import 'package:school_management_app/chat/chat_controller/user_controller.dart';



class AddGroupChat extends StatefulWidget {
  const AddGroupChat({super.key, this.type, this.groupId, this.memberId});
  final String ?type;
  final String ?groupId;
  final List ? memberId;
  

  @override
  State<AddGroupChat> createState() => _AddGroupChatState();
}

class _AddGroupChatState extends State<AddGroupChat> {
  var user = FirebaseAuth.instance.currentUser;
  final ChatController _chatController =Get.put(ChatController());
  final UserController _userController =Get.put(UserController());
  final MainController _mainController =Get.put(MainController());
  
  dynamic userId;
  dynamic userRole;
  dynamic dId;
  dynamic userEmail;
    final box =GetStorage();
    List addUser=[];
     String codeDialog='';
  String valueText='';
  final TextEditingController _textFieldController = TextEditingController();
  @override
  void initState() {
    intialized();
    _userController.getData();
    super.initState();
  }
  intialized(){
    setState(() {
     userId=box.read('userId');
     userRole=box.read('userRole');
      userEmail = box.read('userEmail');
     _mainController.getData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffF5F5F5),
          padding: const EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 0.0),
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
                      if(userList[index]["email"].toString() == read('loginInfoemail')){
                        if(widget.memberId!=null){
                          if(widget.memberId!.contains(userList[index]['userId'].toString())){
                            return const SizedBox();
                          }
                          else{
                            return GroupUserList(
                              data: userList[index],
                              id: userList[index]['userId'],
                              chatController: _chatController,
                              userId: read('userId'),
                            ); 
                          }
                        }else{
                          return GroupUserList(
                            data: userList[index],
                            id: userList[index]['userId'],
                            chatController: _chatController,
                            userId:read('userId'),
                          );   
                        }
                      }
                      else{
                        return  const SizedBox();
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
      actions: [
       TextButton.icon(
          onPressed: (){ 
             if (widget.type=='updateGroup'){
            loadingWidget();
            FirebaseChatServices.groupUpdate(docId: widget.groupId.toString(), userId: _chatController.addUser);
            }else{
              displayTextInputDialog();
            }
          },
          icon: const SizedBox(),
          label: const Text('Next')
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
                child: const Text("Add participants",style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
   Future<void> displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter GroupName'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Enter GroupName"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                loadingWidget();
                  setState(() {
                    codeDialog = valueText;
                    FirebaseChatServices.createGroup(
                    groupName: _textFieldController.text.toString(),
                    description: '',
                    docId:  _mainController.countList[0]["groupchatCount"].toString(),
                    groupImage: '',
                    groupMember: _chatController.addUser,
                    lastMessage: ''
                    );
                  });
                },
              ),
            ],
          );
        });
  }
  
}
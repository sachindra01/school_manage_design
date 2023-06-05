// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, prefer_typing_uninitialized_variables, unused_local_variable, depend_on_referenced_packages

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:school_management_app/chat/group_chat_room/add_group_chat.dart';
import 'package:school_management_app/chat/chat_model/message_model.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';
import 'package:school_management_app/chat/chat_controller/main_controller.dart';
import 'package:school_management_app/chat/chat_controller/user_controller.dart';
import 'package:school_management_app/chat/widget/network_image.dart';
import 'package:timeago/timeago.dart' as timeago;


class GroupChatPage extends StatefulWidget {
  const GroupChatPage({super.key, this.userName, this.id, this.userId, required this.groupMember, required this.profilePhoto,});
  final String? userName;
  final int? id;
  final int? userId;
  final String profilePhoto;
  final List groupMember;

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final MainController _con =Get.put(MainController());
  final UserController _usercon =Get.put(UserController());
  final ChatController _chatController =Get.put(ChatController());
  final box = GetStorage();
  var userId;
  var dId;
  int totalMessageLength= 0;
 
  @override
  void initState() {
    super.initState();
    _con.getData();
    _usercon.getData();
    initalize();
   
  }
  initalize()async{
    setState(() {
    _chatController.messageText.clear();
    _chatController.pickedImage = '';
     dId =_chatController.createdocId(
        widget.id,widget.userId
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        FirebaseChatServices.groupChatlog(userId: widget.userId!.toInt(),groupId: widget.id.toString());
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: appbar(),
        body:  Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: StreamBuilder <List<Message>>(
              stream:FirebaseChatServices.getGroupmessageList(widget.id.toString()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return  SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: const Center(child: CircularProgressIndicator( color: Colors.black,),),
                  );
                } else {
                  totalMessageLength=snapshot.data!.length;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          controller: _chatController.scrollController,
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          reverse: true,
                          padding: const EdgeInsets.only(top: 10,bottom: 0),
                          itemBuilder: (context, index){
                            var datetime= DateFormat("yyyy-MM-dd").parse(snapshot.data![index].datetime.toString());
                            String date = DateFormat("yyyy-MM-dd").format(datetime);
                            final currentTime =snapshot.data![index].datetime;
                            final date2 = DateTime.now();
                            final difference = date2.difference(currentTime!).inHours;
                            var y =   timeago.format(currentTime.subtract( const Duration(microseconds: 1 * 44 * 1000)));
                            return Container(
                              padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                              child:  Row(
                                mainAxisAlignment:snapshot.data![index].senderId!.contains(box.read('userId').toString())?
                                MainAxisAlignment.end:MainAxisAlignment.start,
                                children: [
                                   snapshot.data![index].senderId!.contains(box.read('userId').toString())
                                   ? const SizedBox() 
                                   : Align(
                                    alignment: snapshot.data![index].senderId != widget.userId.toString()?Alignment.topLeft:Alignment.bottomRight,
                                     child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100.00),
                                        child:kIsWeb
                                        ? Image.asset(
                                          "assets/img/profile.png",
                                          height: kIsWeb
                                            ? MediaQuery.of(context).size.height * 0.06
                                            : MediaQuery.of(context).size.height * 0.03,
                                          width:  kIsWeb 
                                            ? MediaQuery.of(context).size.width * 0.03
                                            : MediaQuery.of(context).size.height * 0.03,
                                          fit: BoxFit.cover,
                                        )
                                        : CachedNetworkimage(
                                          imageUrl: snapshot.data![index].senderProfileImageURl.toString(),
                                          height: kIsWeb
                                            ? MediaQuery.of(context).size.height * 0.06
                                            : MediaQuery.of(context).size.height * 0.03,
                                          width:  kIsWeb 
                                            ? MediaQuery.of(context).size.width * 0.03
                                            : MediaQuery.of(context).size.height * 0.03,
                                        )
                                      ),
                                   ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:4.0, bottom: 4.0),
                                        child: Align(
                                          alignment: snapshot.data![index].senderId != widget.userId.toString()?Alignment.topLeft:Alignment.bottomRight,
                                          child: Container(
                                          width: 100,
                                            decoration:  BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                color: Colors.transparent
                                              )
                                              ,borderRadius: const BorderRadius.all(Radius.circular(5))
                                            ),
                                            child: Text(
                                              snapshot.data![index].senderId!.contains(box.read('userId').toString())
                                              ? 'you'
                                              : snapshot.data![index].senderName.toString(),
                                              style: const TextStyle(
                                              color: Color.fromARGB(255, 83, 83, 83),
                                              fontSize: 10,
                                            ),textAlign: snapshot.data![index].senderId.toString() != box.read('userId').toString() ? TextAlign.left :TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: (
                                          snapshot.data![index].senderId != widget.userId.toString()?Alignment.topLeft:Alignment.bottomRight),
                                        child: Container(
                                          margin: snapshot.data![index].senderId.toString() != box.read('userId').toString() ? const EdgeInsets.only( right: 40) : const EdgeInsets.only( left: 40),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: (snapshot.data![index].senderId != widget.userId.toString()?Colors.grey.shade200:Colors.blue[200]),
                                          ),
                                          padding:  const EdgeInsets.all(0),
                                          child: snapshot.data![index].text==''&&snapshot.data![index].file==''
                                            ?  InkWell(
                                              onDoubleTap: (() {
                                                  // Get.to(()=>DetailScreen(
                                                  //   image: snapshot.data![index].image.toString(),
                                                  // ));
                                              }),
                                              child: CachedNetworkimage(
                                                height: 100,
                                                width: 100,
                                                imageUrl: snapshot.data![index].image==''?'' :snapshot.data![index].image.toString(),
                                              ),
                                            )
                                            : snapshot.data![index].file!=''
                                            ?InkWell(
                                              onTap: ()async{
                                                _chatController.downloadFile(snapshot.data![index].file.toString()).then((value) => {
                                                    // _chatController.progressdownload=null,
                                                  OpenFile.open(value)
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                          child: snapshot.data![index].file!.contains('.jpg.webp?')||snapshot.data![index].file!.contains('.png.webp?')||snapshot.data![index].file!.contains('file?')||snapshot.data![index].file!.contains('images?')||snapshot.data![index].file!.contains('.jpg?')||snapshot.data![index].file!.contains('.png?')
                                                          ? CachedNetworkimage(
                                                            height: 100,
                                                            width: 100,
                                                            imageUrl: snapshot.data![index].file==''?'' :snapshot.data![index].file.toString(),
                                                          )
                                                          : Image.asset('assets/img/filepick.png',
                                                          )
                                                        ),
                                                        snapshot.data![index].file!.contains('.jpg?')||snapshot.data![index].file!.contains('.png.webp?')||snapshot.data![index].file!.contains('file?')
                                                        ? const SizedBox()
                                                        : Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Text(getFileName(snapshot.data![index].file.toString()),style: const TextStyle(
                                                            fontSize: 5
                                                          ),),
                                                        ),
                                                        snapshot.data![index].file!.contains('.jpg?')||snapshot.data![index].file!.contains('.png.webp?')||snapshot.data![index].file!.contains('file?')
                                                        ? const SizedBox()
                                                        : const Icon(Icons.download)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                            : Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(snapshot.data![index].text.toString(), style: const TextStyle(fontSize: 16),),
                                            ),
                                        ),
                                      ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:4.0, bottom: 4.0),
                                          child: Align(
                                            alignment: snapshot.data![index].senderId != widget.userId.toString()?Alignment.topLeft:Alignment.bottomRight,
                                            child: Container(
                                            width: 100,
                                              decoration:  BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: Colors.transparent
                                                )
                                                ,borderRadius: const BorderRadius.all(Radius.circular(10))
                                              ),
                                              child: Text(
                                                difference>24
                                                ? date.toString()
                                                : y.toString(),
                                                style: const TextStyle(
                                                color: Color.fromARGB(255, 97, 97, 97),
                                                fontSize: 10
                                              ),
                                              textAlign: snapshot.data![index].senderId.toString() != box.read('userId').toString() ? TextAlign.left :TextAlign.right,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            );
                          },
                        ),
                        GetBuilder(
                          init: ChatController(),
                          builder: (context) {
                            return _chatController.progress!=null
                            ?Padding(
                              padding: const EdgeInsets.only(right: 10.0,top: 15.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: const EdgeInsets.only( left: 40),
                                  child: const CustomShimmer(
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox();
                          }
                        )
                      ],
                    ),
                  );
                }
              }
            ),
          ),
          GetBuilder(
            init: ChatController(),
            builder: (context) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                           Get.bottomSheet(
                                bottomsheetTitle(),
                              );
                           },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                    _chatController. pickedImage==''&&  _chatController. pickedfile==''
                    ? Expanded(
                        child: TextField(
                          controller:  _chatController. messageText,
                          decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none
                          ),
                        ),
                    )
                    : _chatController.pickedfile==''
                    ? ClipRRect(
                      child: Image.file(File(_chatController.pickedImage.toString()),
                    ))
                    : ClipRRect(
                    child:  _chatController.pickedfile.contains('.png.webp')
                    ? Image.memory(_chatController.webfiles)
                    :  _chatController.pickedfile.contains('.png')||_chatController.pickedfile.contains('.jpg')
                    ? Image.file(File(_chatController.pickedfile))
                    : Image.asset('assets/img/filepick.png',
                    )
                  ),
                      const SizedBox(width: 15,),
                      Padding(
                        padding:EdgeInsets.only(
                          left:  _chatController.pickedImage==''
                          ? 0.0
                          : Get.width/2
                        ),
                        child: FloatingActionButton(
                          onPressed: () async{
                            _chatController.handlegroupMsg(
                              _chatController.messageText.text,
                              widget.id,
                              widget.userId,
                              totalMessageLength,
                              box.read("firstName") + box.read("lastName"),
                              box.read('profilePhoto').toString()
                            );
                              //To get user notificationstatus
                              await _usercon.getData();
                              await sendPushNotification(_chatController.messageText.text, "${box.read("firstName")}  ${box.read("lastName")}");
                              _chatController.messageText.clear();
                          },
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          child: const Icon(Icons.send,color: Colors.white,size: 18,),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ],
      ),
      ),
    );
  }


  String getFileName(String url) {
    RegExp regExp =  RegExp(r'.+(\/|%2F)(.+)\?.+'); 
    //This Regex won't work if you remove ?alt...token
    var matches = regExp.allMatches(url);

    var match = matches.elementAt(0);
    if (kDebugMode) {
      print(Uri.decodeFull(match.group(2)!));
    }
    return Uri.decodeFull(match.group(2)!);
  }

  bottomsheetTitle() {
    return Container(
      height: Get.height/5,
      decoration: const BoxDecoration(
        color: Color(0xfff5f5f5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 27.0, bottom: 0.0) ,
        child: Column(
          crossAxisAlignment: kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
           kIsWeb?
           SizedBox(
              width: 340,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _chatController.pickFile().then((value) => {
                      Get.back(),
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  fixedSize: const Size(290.0, 90.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const  [
                    Icon(Icons.file_upload, color: Colors.white, size: 30.0),
                    SizedBox(width: 15,),
                    Text("Upload a File", style: TextStyle(color: Colors.white, fontSize: 22.0)),
                  ],
                )
              ),
            )
           : Column(
              children: [
                InkWell(
                  onTap: (){
                    _chatController. pickImage(ImageSource.gallery).then((value) {
                        Get.back();
                      });
                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:const  [
                      Icon(Icons.photo),
                      SizedBox(
                        width: 280.0,
                        child:  Text('Gallery',style: TextStyle(
                          color: Colors.black,fontSize: 20.0
                        )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    _chatController.pickImage(ImageSource.camera).then((value) => {
                          Get.back(),
                      });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:const  [
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 280.0,
                        child:  Text('Camera',style: TextStyle(
                          color: Colors.black,fontSize: 20.0
                        )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    _chatController.pickFile().then((value) => {
                          Get.back(),
                    });
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const  [
                          Icon(Icons.file_open, color: Colors.black),
                          SizedBox(
                            width: 280.0,
                            child:  Text('File',style: TextStyle(
                              color: Colors.black,fontSize: 20.0
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        )
      )
    );
  }


  appbar(){
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      actions: [
        InkWell(
          onTap: (){
            Get.to(()=> AddGroupChat(
              type: 'updateGroup',
              memberId: widget.groupMember,
              groupId: widget.id.toString(),
            ));
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.add,color: Colors.black,),
          ))
      ],
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  _chatController.progress=null;
                 FirebaseChatServices.groupChatlog(userId: widget.userId!.toInt(),groupId: widget.id.toString());
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back,color: Colors.black,),
              ),
              const SizedBox(width: 2,),
              CircleAvatar(
                maxRadius: 15,
                child: Image.asset('assets/img/logo.png'),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Text(widget.userName.toString(),style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Send Push Notification on message
  sendPushNotification(notificationBody, notificationTitle){
    final user = FirebaseAuth.instance.currentUser;
    //User Fcm
    List userFcmToken = [];
    //All client ID
    for (var i = 0; i < widget.groupMember.length; i++) {
      for (var element in _usercon.userList) {
        if(widget.groupMember[i] == element["userId"].toString() && element["isChatNotification"] == true && user!.email != element["email"]){
          //PlatformCheck
          if(element["fcmAndroid"]  != ""){
          userFcmToken.add(element["fcmAndroid"]);
          }
          if(element["fcmIos"] != ""){
            userFcmToken.add(element["fcmIos"]);
          }
          if(element["fcmWeb"] != ""){
            userFcmToken.add(element["fcmWeb"]);
          }
        }
      }
    }
    if(userFcmToken.isNotEmpty){
      _con.sendChatNotification(userFcmToken, notificationBody.toString(), notificationTitle.toString(), widget.id,);
    }
  }
}
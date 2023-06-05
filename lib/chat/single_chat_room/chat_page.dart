// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, prefer_typing_uninitialized_variables, unused_local_variable, depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/chat/chat_model/message_model.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';
import 'package:school_management_app/chat/chat_controller/main_controller.dart';
import 'package:school_management_app/chat/chat_controller/user_controller.dart';
import 'package:school_management_app/chat/widget/network_image.dart';
import 'package:timeago/timeago.dart' as timeago;


class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.userName, this.id, this.userId, required this.profilePhoto,});
  final String? userName;
  final String profilePhoto;
  final int? id;
  final int? userId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final MainController _con =Get.put(MainController());
  final UserController _usercon =Get.put(UserController());
  final ChatController _chatController =Get.put(ChatController());
  final box = GetStorage();
  var userId;
  var dId;
  int totalMessageLength= 0;
  bool scrollVisibility = false;
 
 
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
        dId =_chatController.createdocId(
        widget.id,widget.userId
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar:  defaultAppbar(
        context,
        leadingIcon: InkWell(
          onTap: (){
            FirebaseChatServices.updateCounter(
              _chatController.createdocId(
                widget.id,widget.userId
              ),
              widget.id!.toInt()
            );
            _chatController.pickedfile='';
            _chatController.pickedImage='';
            _chatController.progress=null;
            Navigator.pop(context);

          },
          child: Container(
             decoration: BoxDecoration(
              boxShadow: const [
                 BoxShadow(
                    color: Colors.grey, // Change color of the shadow
                    blurRadius: 0.0,
                    spreadRadius: 0.1,
                    offset: Offset(0.2, 0.2)
                  )
              ],
              borderRadius: BorderRadius.circular(10), // <= No more error here :)
              color: lGrey,
              ),
              child: const Icon(Icons.arrow_back_ios,color: primaryColor,size: 20,),
          ),
        ) ,
        title: Row(
          children: [
             Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.00),
                  child: widget.profilePhoto == ""
                  ? Image.asset(
                    "assets/img/person1.png",
                    height: kIsWeb
                      ? MediaQuery.of(context).size.height * 0.07
                      : MediaQuery.of(context).size.height * 0.04,
                    width:  kIsWeb 
                      ? MediaQuery.of(context).size.width * 0.07
                      : MediaQuery.of(context).size.height * 0.04,
                    fit: BoxFit.cover,
                  )
                  : CachedNetworkimage(
                    imageUrl: widget.profilePhoto.toString(),
                    height: kIsWeb
                      ? MediaQuery.of(context).size.height * 0.07
                      : MediaQuery.of(context).size.height * 0.04,
                    width:  kIsWeb 
                      ? MediaQuery.of(context).size.width * 0.04
                      : MediaQuery.of(context).size.height * 0.04,
                  )
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            Text(widget.userName.toString()
            ),
          ],
        ),
        
        ),
      floatingActionButton: Visibility(
        visible: scrollVisibility,
        child: Padding(
          padding: const EdgeInsets.only(bottom:68.0, right: 0),
          child: SizedBox(
            height: 65,
            width: 65,
            child: FloatingActionButton(
              onPressed: (){
                _chatController.scrollDown();
              },
              heroTag: "Scroll Down",
              child: const Icon(Icons.keyboard_double_arrow_down, size: 30,), 
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: StreamBuilder <List<Message>>(
              stream:FirebaseChatServices.getmessageList(dId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return  SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: const Center(child: CircularProgressIndicator( color: Colors.black,),),
                  );
                } else {
                  totalMessageLength=snapshot.data!.length;
                  return Column(
                    children: [
                      Flexible(
                        child: NotificationListener<ScrollUpdateNotification>(
                          child: ListView.builder(
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
                                padding: const EdgeInsets.only(left: 10,right: 12,top: 10,bottom: 10),
                                child:  Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:4.0, bottom: 4.0),
                                      child: Align(
                                        alignment: snapshot.data![index].senderId != widget.userId.toString()?Alignment.topLeft:Alignment.bottomRight,
                                        child: Row(
                                          mainAxisAlignment:snapshot.data![index].senderId!.contains(read('userId').toString())?
                                          MainAxisAlignment.end:MainAxisAlignment.start,
                                          children: [
                                            snapshot.data![index].senderId == widget.userId.toString()
                                            ? const SizedBox()
                                            : SizedBox( width:  MediaQuery.of(context).size.height *0.045,),
                                            Container(
                                            width: 100,
                                              decoration:  BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: Colors.transparent
                                                )
                                                ,borderRadius: const BorderRadius.all(Radius.circular(5))
                                              ),
                                              child: Text(
                                                snapshot.data![index].senderId!.contains(read('userId').toString())
                                                ? 'you'
                                                : snapshot.data![index].senderName.toString(),
                                                style: const TextStyle(
                                                color: Color.fromARGB(255, 83, 83, 83),
                                                fontSize: 10,
                                              ),textAlign: snapshot.data![index].senderId.toString() != read('userId').toString() ? TextAlign.left :TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                    alignment: (
                                      snapshot.data![index].senderId != widget.userId.toString()?Alignment.topLeft:Alignment.bottomRight),
                                      child: Row(
                                        mainAxisAlignment:snapshot.data![index].senderId!.contains(read('userId').toString())?
                                        MainAxisAlignment.end:MainAxisAlignment.start,
                                        children: [
                                          snapshot.data![index].senderId == widget.userId.toString()
                                            ? const SizedBox()
                                            : ClipRRect(
                                              borderRadius: BorderRadius.circular(100.00),
                                              child: widget.profilePhoto == ""
                                              ? Image.asset(
                                                "assets/img/person1.png",
                                                height: kIsWeb
                                                  ? MediaQuery.of(context).size.height * 0.065
                                                  : MediaQuery.of(context).size.height * 0.035,
                                                width:  kIsWeb 
                                                  ? MediaQuery.of(context).size.width * 0.035
                                                  : MediaQuery.of(context).size.height * 0.035,
                                                fit: BoxFit.cover,
                                            )
                                            : CachedNetworkimage(
                                              imageUrl: snapshot.data![index].senderProfileImageURl.toString(),
                                              height: kIsWeb
                                                ? MediaQuery.of(context).size.height * 0.065
                                                : MediaQuery.of(context).size.height * 0.035,
                                              width:  kIsWeb 
                                                ? MediaQuery.of(context).size.width * 0.035
                                                : MediaQuery.of(context).size.height * 0.035,
                                            )
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width *0.02,),
                                          Flexible(
                                            child: Container(
                                              margin: snapshot.data![index].senderId.toString() != read('userId').toString() ? const EdgeInsets.only( right: 40) : const EdgeInsets.only( left: 40),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: (snapshot.data![index].senderId != widget.userId.toString()?Colors.grey.shade200:Colors.blue[200]),
                                              ),
                                              child: snapshot.data![index].text==''&&snapshot.data![index].file==''
                                              ?  InkWell(
                                                onTap: (() {
                                                    // Get.to(()=>DetailScreen(
                                                    //   image: snapshot.data![index].image.toString(),
                                                    // ));
                                                }),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: CachedNetworkimage(
                                                    height: 160,
                                                    width: 130,
                                                    imageUrl: snapshot.data![index].image==''?'' :snapshot.data![index].image.toString(),
                                                  ),
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
                                                            : Image.asset('assets/img/pdf1.png',
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
                                                padding: const EdgeInsets.only(top:6.0,bottom: 10.0, left: 10.0, right: 10.0),
                                                child: Text(
                                                  snapshot.data![index].text.toString(), 
                                                  style: const TextStyle(fontSize: 16, height: 1.4),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:4.0, bottom: 4.0),
                                      child: Align(
                                        alignment: snapshot.data![index].senderId != widget.userId.toString()?Alignment.topLeft:Alignment.bottomRight,
                                        child: Row(
                                        mainAxisAlignment:snapshot.data![index].senderId!.contains(read('userId').toString())?
                                        MainAxisAlignment.end:MainAxisAlignment.start,
                                          children: [
                                          snapshot.data![index].senderId == widget.userId.toString()
                                          ? const SizedBox()
                                          : SizedBox( width:  MediaQuery.of(context).size.height *0.045,),
                                            Container(
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
                                              textAlign: snapshot.data![index].senderId.toString() != read('userId').toString() ? TextAlign.left :TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          onNotification: (notification) {
                            if(notification.metrics.pixels > 700.0){
                              setState(() {
                                scrollVisibility = true;
                              });
                            }
                            else{
                              setState(() {
                                scrollVisibility = false;
                              });
                            }
                            return true;
                          },
                        ),
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
                  );
                }
              }
            ),
          ),
          sendButton(),
         
        ],
      ),
    );
  }

  sendButton(){
    return  GetBuilder(
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
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller:  _chatController. messageText,
                    onFieldSubmitted: (value) async{
                      _chatController.handleSendPressed(
                        _chatController.messageText.text,
                        widget.id,
                        widget.userId,
                        totalMessageLength,
                      widget.userName.toString(),
                        ''
                      );
                        //To get user notificationstatus
                        await _usercon.getData();
                        await sendPushNotification(_chatController.messageText.text, widget.userName.toString());
                        _chatController.messageText.clear();
                    },
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
                  : Image.asset('assets/img/pdf1.png',
                  )
                ),
                _chatController.pickedImage=='' 
                ? const SizedBox(width: 15,)
                : const Spacer(),
                Padding(
                  padding:EdgeInsets.only(
                    left:  _chatController.pickedImage==''
                    ? 0.0
                    : 5
                  ),
                  child: FloatingActionButton(
                    onPressed: () async{
                      _chatController.handleSendPressed(
                        _chatController.messageText.text,
                        widget.id,
                        widget.userId,
                        totalMessageLength,
                        widget.userName.toString(),
                        ''
                      );
                        //To get user notificationstatus
                        await _usercon.getData();
                        await sendPushNotification(_chatController.messageText.text, widget.userName,widget.id);
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
    );
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


  appbar(){
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            // colors: [Colors.deepPurple, Colors.purple],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(220, 46, 36, 72),
            // Color.fromARGB(255, 230, 149, 45),
            Color.fromARGB(255, 223, 104, 144),
              ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          ),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: (){
                   FirebaseChatServices.updateCounter(
                    _chatController.createdocId(
                     widget.id,widget.userId
                    ),
                    widget.id!.toInt()
                  );
                  _chatController.pickedfile='';
                  _chatController.pickedImage='';
                  _chatController.progress=null;
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back,color: Colors.black,),
              ),
              const SizedBox(width: 2,),
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.00),
                  child: widget.profilePhoto == ""
                  ? Image.asset(
                    "assets/img/person1.png",
                    height: kIsWeb
                      ? MediaQuery.of(context).size.height * 0.07
                      : MediaQuery.of(context).size.height * 0.04,
                    width:  kIsWeb 
                      ? MediaQuery.of(context).size.width * 0.07
                      : MediaQuery.of(context).size.height * 0.04,
                    fit: BoxFit.cover,
                  )
                  : CachedNetworkimage(
                    imageUrl: widget.profilePhoto.toString(),
                    height: kIsWeb
                      ? MediaQuery.of(context).size.height * 0.07
                      : MediaQuery.of(context).size.height * 0.04,
                    width:  kIsWeb 
                      ? MediaQuery.of(context).size.width * 0.04
                      : MediaQuery.of(context).size.height * 0.04,
                  )
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:6.0),
                  child: Text(widget.userName.toString(),style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Send Push Notification on message,
  sendPushNotification(notificationBody, notificationTitle, [recevierId]){
    //User Fcm
    List userFcmToken = [];
    //All client ID
    for (var element in _usercon.userList) {
      if(recevierId == element["userId"] && element["isChatNotification"] == true){
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
    if(userFcmToken.isNotEmpty){
      _con.sendChatNotification(userFcmToken, notificationBody.toString(), notificationTitle.toString(), box.read("profilePhoto"));
    }
  }
}
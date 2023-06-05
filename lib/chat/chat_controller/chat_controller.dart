// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';

class ChatController extends GetxController{
  final ScrollController scrollController = ScrollController(initialScrollOffset: 0.0);
  final TextEditingController messageText=TextEditingController();
  User? user =FirebaseAuth.instance.currentUser;
  File?file;
  String pickedImage='';
  var pimage;
  String pickedfile='';
  String kwebselctFile='';
  var box= GetStorage();
  dynamic userId;
  dynamic webfiles;
  dynamic fileSelected;
  dynamic selectedFilePath;
  var dId;
  RxBool imagePicked = false.obs;
  dynamic progress;
  dynamic progressdownload;
   RxString completedUploadImages = '0.0 %'.obs;
  int imageUploaded = 0;
  List<XFile> multiImagefiles = [];
  //Create Group added Users List 
  List addUser = [];
  void scrollDown() {
    scrollController.animateTo(
      0.0,  
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
    );
  }

 Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result==null){

    }else{
      
        pickedfile=result.files.first.path!;
        file = File(result.files.first.path!);
        selectedFilePath = result.files.first.path!;
        fileSelected= result.files.first.bytes;
        kwebselctFile = result.files.first.name;
        update();
      
    }
  }
  

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker(
      ).pickImage(source: source,imageQuality: 50);
      if (image == null) return;
         pimage=image.path;
        file = File(image.path);
        pickedImage=image.path.toString();
        multiImagefiles.add(image);
        imagePicked.value=true;
        update();
      
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to upload image: $e");
    }
  }

  createdocId(id,userId){
    var docId;
    if(id!=null &&userId!=null){
    if(id>userId){
      docId = '''$userId-$id''';
      
    }else{
      docId = '''$id-$userId''';
    }
    return docId;
    }
  }

   void handleSendPressed(text,id,userId,totalMsgLength,senderName,sendprofilePic) {
    String sendText = text.trim();
    userId=box.read('userId');
     dId= createdocId(id, userId);
    if(sendText!=""&&pickedImage==''){
      FirebaseChatServices.sendMessage(
        docId: dId,
        senderId: userId,
        senderName: senderName,
        senderProfileImageUrl: sendprofilePic,
        text:sendText.toString(), 
        checkMsgEmpty: totalMsgLength==0?true:false,
      ).then((value) => {
        scrollDown(),
        messageText.clear(),
        progress=null,
        update(),
      });
    }else if (pickedImage!=''&&pickedfile==''){
      update();
      FirebaseChatServices.uploadImageMessage(
        docId:dId,
        senderId: userId,
        senderName:senderName,
        senderProfileImageUrl: sendprofilePic,
        fileName: kIsWeb? kwebselctFile:"",
        text:'',
        imageFile: kIsWeb?webfiles:file
      ).then((value) => {
        pickedImage="",
        progress=null,
        update(),
        scrollDown()
      });
    }else{
       FirebaseChatServices.uploadFileMessage(
        docId:dId,
        senderId: userId,
        senderName:senderName,
        senderProfileImageUrl: sendprofilePic,
        fileName: kIsWeb? kwebselctFile:kwebselctFile,
        text:'',
        imageFile: kIsWeb?webfiles:file,
        fileUploading: fileSelected,
        filepath: selectedFilePath
      ).then((value) => {
        pickedfile="",
        update(),
        scrollDown()
      });

    }
  }

 

  void handlegroupMsg(text,id,userId,totalMsgLength,senderName,sendprofilePic) {
    String sendText = text.trim();
    userId=box.read('userId');
    if(sendText!=""&&pickedImage==''){
      FirebaseChatServices.sendgroupMessage(
        docId: id.toString(),
        senderId: userId,
        senderName: senderName,
        senderProfileImageUrl: sendprofilePic,
        text:sendText.toString(), 
        checkMsgEmpty: totalMsgLength==0?true:false,
        fileName: '',
        imageFile:'',
      ).then((value) => {
        messageText.clear(),
        progress=null,
        update(),
        scrollDown()
      });
    }else if(pickedImage!=''&&pickedfile==''){
      FirebaseChatServices.groupchatuploadImageMessage(
        docId: id.toString(),
        senderId: userId,
        senderName:senderName,
        senderProfileImageUrl:sendprofilePic,
        fileName: kIsWeb? kwebselctFile:"",
        text:'',
        imageFile: kIsWeb?webfiles:file
      ).then((value) => {
        pickedImage="",
        progress=null,
        update(),
        scrollDown()
      });
    }else{
      FirebaseChatServices.uploadGroupFileMessage(
        docId:id.toString(),
        senderId: userId,
        senderName:senderName,
        senderProfileImageUrl: sendprofilePic,
        fileName: kIsWeb? kwebselctFile:kwebselctFile,
        text:'',
        imageFile: kIsWeb?webfiles:file,
        fileUploading: fileSelected,
        filepath: selectedFilePath
      ).then((value) => {
        pickedfile="",
        update(),
        scrollDown()
      });

    }
  }

  



   Future downloadFile(url) async {
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    var pdfDownloadPath = '${dir.path}/news.pdf';
    await dio.download(
      url .toString(),
        pdfDownloadPath, onReceiveProgress: (received, total) {
      progressdownload = (received / total) * 100;
      debugPrint('Rec: $received , Total: $total, $progress%');
      if(progress==100){
        if (kDebugMode) {
          print('downloaded');
        }
      }
    });

    return pdfDownloadPath;
  }


  void clientPressed(text,id,userId,totalMsgLength,indexId,type, senderName) {
    String sendText = text.trim();
    userId=box.read('userId');
    if(sendText!=""){
      FirebaseChatServices.sendClientNote(
        type: type,
        indexId:indexId.toString() ,
        docId: id.toString(),
        senderId: userId,
        senderName: senderName,
        senderProfileImageUrl: '',
        text:sendText.toString(), 
        checkMsgEmpty:true,
      ).then((value) => {
        messageText.clear(),
        scrollDown()
      });
    }else{
      FirebaseChatServices.uploadImageMessage(
        docId:id.toString(),
        senderId: userId,
        senderName: user!.email.toString(),
        senderProfileImageUrl: '',
        text:sendText.toString(),
        imageFile: file
      );
    }
  }
  void teamPressed(text,id,userId,totalMsgLength,indexId,type, userName) {
    String sendText = text.trim();
    userId=box.read('userId');
    if(sendText!=""){
      FirebaseChatServices.sendTeamNote(
        docId: id.toString(),
        senderId: userId,
        indexId: indexId.toString(),
        senderName: userName,
        senderProfileImageUrl: '',
        text:sendText.toString(), 
        type: type,
        checkMsgEmpty: totalMsgLength==0?true:false,
      ).then((value) => {
        messageText.clear(),
        scrollDown()
      });
    }else{
      FirebaseChatServices.uploadImageMessage(
        docId:dId,
        senderId: userId,
        senderName: userName,
        senderProfileImageUrl: '',
        text:sendText.toString(),
        imageFile: file
      );
    }
  }
}
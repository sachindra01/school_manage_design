// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:school_management_app/chat/chat_model/message_model.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';

class FirebaseChatServices{
 
  //Send Message
  static Future<void> sendMessage({
    String ?docId,
    required int senderId,
    required String senderName,
    required String senderProfileImageUrl,
    required String text,
    String? fileUrl,
    String? fileName,
    File? file,
    required bool checkMsgEmpty,
  }) async {
    var splitDoc = docId!.split('-');
    var split1 =splitDoc[0];
    var split2 =splitDoc[1];
    String name1 = '${splitDoc[0]}_unread_count';
    String name2 = '${splitDoc[1]}_unread_count';
    DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId).collection('chat-message').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "sender_id"  : senderId,
      "sender_name": senderName,
      "sender_profile_image_url"  : senderProfileImageUrl,
      "system_message":false,
      "text"  : text,
      "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
      "datetime":DateTime.now(),
      "deleted" : false,
      "images" :''
    };
    await documentReferencer
    .set(data)
    .whenComplete(() async{
      dynamic data;
      DocumentReference documentReferencer = FirebaseFirestore.instance.collection('chat').doc(docId);
      if(senderId.toString()==split1){
        if(checkMsgEmpty==true){
          data = <String, dynamic>{
            name1: 0,
            name2: FieldValue.increment(1),
            'id' : split1,
            'id2' : split2,
          };
        }
        else{
          data = <String, dynamic>{
            name2: FieldValue.increment(1),
          };
        }
      }else if(senderId.toString()==split2){
        if(checkMsgEmpty==true){
          data = <String, dynamic>{
            name1: FieldValue.increment(1),
            name2: 0,
            'id' : split1,
            'id2' : split2,
          };
        }
        else{
          data = <String, dynamic>{
            name1: FieldValue.increment(1),
          };
        }
      }
      if(checkMsgEmpty==true){
        await documentReferencer.set(data);
      }
      else{
        await documentReferencer.update(data);
      }
      FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"chatCount" :  0 + 1});
      //
    })
    .catchError((e) {
      //
    });
  }

  //show message list from firebase
  static Stream <List<Message>>getmessageList(docId) {
    try{
      return  FirebaseFirestore.instance
      .collection("chat")
      .doc(docId).collection('chat-message')
      .orderBy('unix_timestamp',descending: true)
      .snapshots()
      .map((message){
         final List<Message> messagesFromFirestore = <Message>[];
          for(final DocumentSnapshot<Map<String,dynamic>> doc in message.docs){
            messagesFromFirestore.add(Message.fromDocumentSnapshot(doc:doc));
          }
        return messagesFromFirestore;
      });
    }
    catch (e){
      rethrow;
    }
  } 
   //show message list from firebase
  static Stream <List<Message>>getGroupmessageList(docId) {
    try{
      return  FirebaseFirestore.instance
      .collection("group_chat_room")
      .doc(docId).collection('chat-message')
      .orderBy('unix_timestamp',descending: true)
      .snapshots()
      .map((message){
         final List<Message> messagesFromFirestore = <Message>[];
          for(final DocumentSnapshot<Map<String,dynamic>> doc in message.docs){
            messagesFromFirestore.add(Message.fromDocumentSnapshot(doc:doc));
          }
        return messagesFromFirestore;
      });
    }
    catch (e){
      rethrow;
    }
  } 

    //show clientmessage list from firebase
  static Stream <List<Message>>getClientmessagenote(docId,indexId,type) {
    try{
      return  FirebaseFirestore.instance
      .collection("manifestTask")
      .doc(docId.toString()).collection(type.toString()).doc(indexId.toString()).collection('client_notes')
      .orderBy('unix_timestamp',descending: true)
      .snapshots()
      .map((message){
         final List<Message> messagesFromFirestore = <Message>[];
          for(final DocumentSnapshot<Map<String,dynamic>> doc in message.docs){
            messagesFromFirestore.add(Message.fromDocumentSnapshot(doc:doc));
          }
        return messagesFromFirestore;
      });
    }
    catch (e){
      rethrow;
    }
  } 

     //show teammessage list from firebase
  static Stream <List<Message>>getTeammessagenote(docId,indexId,type) {
    try{
      return  FirebaseFirestore.instance .collection("manifestTask")
      .doc(docId.toString()).collection(type.toString()).doc(indexId.toString()).collection('team_notes')
      .orderBy('unix_timestamp',descending: true)
      .snapshots()
      .map((message){
         final List<Message> messagesFromFirestore = <Message>[];
          for(final DocumentSnapshot<Map<String,dynamic>> doc in message.docs){
            messagesFromFirestore.add(Message.fromDocumentSnapshot(doc:doc));
          }
        return messagesFromFirestore;
      });
    }
    catch (e){
      rethrow;
    }
  } 
//upload images using the imagepicker

 static uploadImageMessage({
    String ?docId,
    required int senderId,
    required String senderName,
    required String senderProfileImageUrl,
    required String text,
    String? fileUrl,
    String? fileName,
    dynamic imageFile,
    dynamic totalImages,
  }) async {
    UploadTask uploadTask;
     final ChatController chatController =Get.put(ChatController());
    String url ='';
    if(kIsWeb){
      final firebaseStorageRef = FirebaseStorage.instance.ref().child("images/$fileName");
      uploadTask = firebaseStorageRef.putData(imageFile,
      SettableMetadata(contentType: 'images/$fileName'));
          uploadTask.snapshotEvents.listen((event) { 
          chatController. progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble()*100;
          });
          uploadTask.whenComplete(() async {
          chatController.imageUploaded = chatController.imageUploaded + 1;
          chatController. completedUploadImages.value = '${chatController.imageUploaded/1*100} %';
          chatController. progress((chatController.imageUploaded/1)*1.0);
          url = await firebaseStorageRef.getDownloadURL();
          var splitDoc = docId!.split('-');
          var split1 =splitDoc[0];
          var split2 =splitDoc[1];
        String name1 = '${splitDoc[0]}_unread_count';
        String name2 = '${splitDoc[1]}_unread_count'; 
       DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId).collection('chat-message').doc();
      Map<String, dynamic> data = <String, dynamic>{
        "sender_id"  : senderId,
        "sender_name": senderName,
        "sender_profile_image_url" : senderProfileImageUrl,
        "system_message":false,
        "text"  : text,
        "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
        "datetime":DateTime.now(),
        "deleted" : false,
        "images" :url
      };
      await documentReferencer
      .set(data)
      .whenComplete(() async{
        DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId);
      if(senderId.toString()==split1){
        Map<String, dynamic> data = <String, dynamic>{
          name2: FieldValue.increment(1),
          name1: 0,
        };
        await documentReferencer
      .update(data);
      }else if(senderId.toString()==split2){
         Map<String, dynamic> data = <String, dynamic>{
        name1: FieldValue.increment(1),
         name2: 0,
      };
        await documentReferencer
      .update(data);
      }else{
         Map<String, dynamic> data = <String, dynamic>{
        name1: 0,
        name2: 0,
      };
        await documentReferencer
      .update(data);

      }
      FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"chatCount" :  0 + 1});
      })
      .catchError((e) {
        //
      });
    });
    }else{
      String fileNames = basename(imageFile!.path);
      final firebaseStorageRef = FirebaseStorage.instance.ref().child("images/$fileNames");
      uploadTask = firebaseStorageRef.putFile(File(imageFile.path));
      uploadTask.snapshotEvents.listen((event) { 
       chatController. progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble()*100;
      });
      uploadTask.whenComplete(() async {
          url = await firebaseStorageRef.getDownloadURL();
          chatController. progress = null;
          var splitDoc = docId!.split('-');
          var split1 =splitDoc[0];
          var split2 =splitDoc[1];
          String name1 = '${splitDoc[0]}_unread_count';
          String name2 = '${splitDoc[1]}_unread_count'; 
         DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId).collection('chat-message').doc();
        Map<String, dynamic> data = <String, dynamic>{
          "sender_id"  : senderId,
          "sender_name": senderName,
          "sender_profile_image_url" : senderProfileImageUrl,
          "system_message":false,
          "text"  : text,
          "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
          "datetime":DateTime.now(),
          "deleted" : false,
          "images" :url
        };
        await documentReferencer
        .set(data)
        .whenComplete(() async{
          DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId);
      if(senderId.toString()==split1){
        Map<String, dynamic> data = <String, dynamic>{
          name2: FieldValue.increment(1),
          name1: 0,
        };
        await documentReferencer
      .update(data);
      }else if(senderId.toString()==split2){
         Map<String, dynamic> data = <String, dynamic>{
        name1: FieldValue.increment(1),
         name2: 0,
      };
        await documentReferencer
      .update(data);
      }else{
         Map<String, dynamic> data = <String, dynamic>{
        name1: 0,
        name2: 0,
      };
        await documentReferencer
      .update(data);

      }
      FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"chatCount" :  0 + 1});
        })
        .catchError((e) {
          //
        });
    });   
    }
  }

  //uploading images/files using the filepicker in firebase
  static uploadFileMessage({
    String ?docId,
    required int senderId,
    required String senderName,
    required String senderProfileImageUrl,
    required String text,
    String? fileUrl,
    String? fileName,
    dynamic imageFile,
    dynamic totalImages,
    dynamic fileUploading,
    dynamic filepath
  }) async {
    UploadTask uploadTask;
     final ChatController chatController =Get.put(ChatController());
    String url ='';
    if(kIsWeb){
      final firebaseStorageRef = FirebaseStorage.instance.ref().child("file/$fileName");
      uploadTask = firebaseStorageRef.putData(imageFile,
      SettableMetadata(contentType: 'file/$fileName'));
          uploadTask.snapshotEvents.listen((event) { 
          chatController. progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble()*100;
          });
          uploadTask.whenComplete(() async {
          url = await firebaseStorageRef.getDownloadURL();
          chatController.progress=null;
          var splitDoc = docId!.split('-');
          var split1 =splitDoc[0];
          var split2 =splitDoc[1];
        String name1 = '${splitDoc[0]}_unread_count';
        String name2 = '${splitDoc[1]}_unread_count'; 
       DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId).collection('chat-message').doc();
      Map<String, dynamic> data = <String, dynamic>{
        "sender_id"  : senderId,
        "sender_name": senderName,
        "sender_profile_image_url" : senderProfileImageUrl,
        "system_message":false,
        "text"  : text,
        "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
        "datetime":DateTime.now(),
        "deleted" : false,
        "images" :'',
        "file" : url
      };
      await documentReferencer
      .set(data)
      .whenComplete(() async{
        DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId);
      if(senderId.toString()==split1){
        Map<String, dynamic> data = <String, dynamic>{
          name2: FieldValue.increment(1),
          name1: 0,
        };
        await documentReferencer
      .update(data);
      }else if(senderId.toString()==split2){
         Map<String, dynamic> data = <String, dynamic>{
        name1: FieldValue.increment(1),
         name2: 0,
      };
        await documentReferencer
      .update(data);
      }else{
         Map<String, dynamic> data = <String, dynamic>{
        name1: 0,
        name2: 0,
      };
        await documentReferencer
      .update(data);

      }
      FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"chatCount" :  0 + 1});
      })
      .catchError((e) {
        //
      });
    });
    }else{
      if(filepath.contains('.jpg')||filepath.contains('.png')){
         final firebaseStorageRef = FirebaseStorage.instance.ref().child("images/$fileName");
          uploadTask = firebaseStorageRef.putFile(File(imageFile.path) , SettableMetadata(contentType: 'images/$fileName'));
          uploadTask.snapshotEvents.listen((event) { 
            chatController. progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble()*100;
          });
          uploadTask.whenComplete(() async {
          url = await firebaseStorageRef.getDownloadURL();
          chatController. progress = null;
          var splitDoc = docId!.split('-');
          var split1 =splitDoc[0];
          var split2 =splitDoc[1];
          String name1 = '${splitDoc[0]}_unread_count';
          String name2 = '${splitDoc[1]}_unread_count'; 
          DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId).collection('chat-message').doc();
          Map<String, dynamic> data = <String, dynamic>{
            "sender_id"  : senderId,
            "sender_name": senderName,
            "sender_profile_image_url" : senderProfileImageUrl,
            "system_message":false,
            "text"  : text,
            "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
            "datetime":DateTime.now(),
            "deleted" : false,
            "images" :'',
            "file":url
          };
        await documentReferencer.set(data).whenComplete(() async{
          DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId);
          if(senderId.toString()==split1){
            Map<String, dynamic> data = <String, dynamic>{
              name2: FieldValue.increment(1),
              name1: 0,
            };
            await documentReferencer
          .update(data);
          }
          else if(senderId.toString()==split2){
            Map<String, dynamic> data = <String, dynamic>{
              name1: FieldValue.increment(1),
              name2: 0,
            };
              await documentReferencer
            .update(data);
          }
      else{
          Map<String, dynamic> data = <String, dynamic>{
          name1: 0,
          name2: 0,
        };
          await documentReferencer
        .update(data);
      }
      FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"chatCount" :  0 + 1});
        })
        .catchError((e) {
          //
        });
    }); 
      }else{
         final firebaseStorageRef = FirebaseStorage.instance.ref().child("file/files/$fileName");
          File file =File(filepath);
          uploadTask = firebaseStorageRef.putFile(file,
          SettableMetadata(contentType: 'file/files/$fileName')
          );
          uploadTask.snapshotEvents.listen((event) { 
          chatController.progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble()*100;
          });
        uploadTask.whenComplete(() async {
          url = await firebaseStorageRef.getDownloadURL();
          chatController.progress = null;
          var splitDoc = docId!.split('-');
          var split1 =splitDoc[0];
          var split2 =splitDoc[1];
          String name1 = '${splitDoc[0]}_unread_count';
          String name2 = '${splitDoc[1]}_unread_count'; 
          DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId).collection('chat-message').doc();
          Map<String, dynamic> data = <String, dynamic>{
            "sender_id"  : senderId,
            "sender_name": senderName,
            "sender_profile_image_url" : senderProfileImageUrl,
            "system_message":false,
            "text"  : text,
            "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
            "datetime":DateTime.now(),
            "deleted" : false,
            "images" :'',
            "file":url
          };
        await documentReferencer.set(data).whenComplete(() async{
          DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId);
          if(senderId.toString()==split1){
            Map<String, dynamic> data = <String, dynamic>{
              name2: FieldValue.increment(1),
              name1: 0,
            };
            await documentReferencer.update(data);
          }
          else if(senderId.toString()==split2){
            Map<String, dynamic> data = <String, dynamic>{
              name1: FieldValue.increment(1),
              name2: 0,
            };
              await documentReferencer.update(data);
          }
          else{
              Map<String, dynamic> data = <String, dynamic>{
              name1: 0,
              name2: 0,
            };
              await documentReferencer.update(data);
          }
          FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"chatCount" :  0 + 1});
       })
        .catchError((e) {
          //
        });
    }); 
      }
     
    }
  }


   static Future<void> sendgroupMessage({
     String ?docId,
    required int senderId,
    required String senderName,
    required String senderProfileImageUrl,
    required String text,
    required bool checkMsgEmpty,
    String? fileUrl,
    String? fileName,
    dynamic imageFile,
    dynamic totalImages,
  }) async {
    // var splitDoc = docId!.split('-');
    // var split1 =splitDoc[0];
    // var split2 =splitDoc[1];
    // String name1 = '${splitDoc[0]}_unread_count';
    // String name2 = '${splitDoc[1]}_unread_count';
    DocumentReference documentReferencer =FirebaseFirestore.instance.collection('group_chat_room').doc(docId).collection('chat-message').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "sender_id"  : senderId,
      "sender_name": senderName,
      "sender_profile_image_url"  : senderProfileImageUrl,
      "system_message":false,
      "text"  : text,
      "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
      "datetime":DateTime.now(),
      "deleted" : false,
      "images" :'',
       "file": ''
    };
    await documentReferencer
    .set(data)
    .whenComplete(() async{
      // dynamic data;
      // DocumentReference documentReferencer = FirebaseFirestore.instance.collection('chat').doc(docId);
      // if(senderId.toString()==split1){
      //   if(checkMsgEmpty==true){
      //     data = <String, dynamic>{
      //       name1: 0,
      //       name2: FieldValue.increment(1),
      //     };
      //   }
      //   else{
      //     data = <String, dynamic>{
      //       name2: FieldValue.increment(1),
      //     };
      //   }
      // }else if(senderId.toString()==split2){
      //   if(checkMsgEmpty==true){
      //     data = <String, dynamic>{
      //       name1: FieldValue.increment(1),
      //       name2: 0,
      //     };
      //   }
      //   else{
      //     data = <String, dynamic>{
      //       name1: FieldValue.increment(1),
      //     };
      //   }
      // }
      // if(checkMsgEmpty==true){
      //   await documentReferencer.set(data);
      // }
      // else{
      //   await documentReferencer.update(data);
      // }
      // FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"chatCount" :  0 + 1});
      //
    })
    .catchError((e) {
      //
    });
  }


  //uploading the images to firebase from groupchat
   static groupchatuploadImageMessage({
    String ?docId,
    required int senderId,
    required String senderName,
    required String senderProfileImageUrl,
    required String text,
    String? fileUrl,
    String? fileName,
    dynamic imageFile,
    dynamic totalImages,
  }) async {
      final ChatController chatController =Get.put(ChatController());
      UploadTask uploadTask;
      String url ='';
    if(kIsWeb){
      final firebaseStorageRef = FirebaseStorage.instance.ref().child("images/$fileName");
      uploadTask = firebaseStorageRef.putData(imageFile,
      SettableMetadata(contentType: 'images/$fileName'));
      uploadTask.whenComplete(() async {
      chatController.imageUploaded = chatController.imageUploaded + 1;
      chatController. completedUploadImages.value = '${chatController.imageUploaded/1*100} %';
      chatController. progress((chatController.imageUploaded/1)*1.0);
      url = await firebaseStorageRef.getDownloadURL();
      DocumentReference documentReferencer =FirebaseFirestore.instance.collection('group_chat_room').doc(docId).collection('chat-message').doc();
      Map<String, dynamic> data = <String, dynamic>{
        "sender_id"  : senderId,
        "sender_name": senderName,
        "sender_profile_image_url" : senderProfileImageUrl,
        "system_message":false,
        "text"  : text,
        "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
        "datetime":DateTime.now(),
        "deleted" : false,
        "images" :url,
         "file": ''
      };
      await documentReferencer
      .set(data)
      .whenComplete(() async{
      })
      .catchError((e) {
        //
      });
    });
    }else{
      String fileNames = basename(imageFile!.path);
      final firebaseStorageRef = FirebaseStorage.instance.ref().child("images/$fileNames");
      uploadTask = firebaseStorageRef.putFile(File(imageFile.path));
      uploadTask.whenComplete(() async {
        chatController.imageUploaded = chatController.imageUploaded + 1;
        chatController. completedUploadImages.value = '${chatController.imageUploaded/1*100} %';
        chatController. progress((chatController.imageUploaded/1)*1.0);
        url = await firebaseStorageRef.getDownloadURL();
        DocumentReference documentReferencer =FirebaseFirestore.instance.collection('group_chat_room').doc(docId).collection('chat-message').doc();
        Map<String, dynamic> data = <String, dynamic>{
          "sender_id"  : senderId,
          "sender_name": senderName,
          "sender_profile_image_url" : senderProfileImageUrl,
          "system_message":false,
          "text"  : text,
          "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
          "datetime":DateTime.now(),
          "deleted" : false,
          "images" :url,
           "file": ''
        };
        await documentReferencer
        .set(data)
        .whenComplete(() async{
        })
        .catchError((e) {
          //
        });
    });   
    }
    }

  static uploadGroupFileMessage({
    String ?docId,
    required int senderId,
    required String senderName,
    required String senderProfileImageUrl,
    required String text,
    String? fileUrl,
    String? fileName,
    dynamic imageFile,
    dynamic totalImages,
    dynamic fileUploading,
    dynamic filepath
  }) async {
    UploadTask uploadTask;
     final ChatController chatController =Get.put(ChatController());
    String url ='';
    if(kIsWeb){
      final firebaseStorageRef = FirebaseStorage.instance.ref().child("file/$fileName");
      uploadTask = firebaseStorageRef.putData(imageFile,
      SettableMetadata(contentType: 'file/$fileName'));
          uploadTask.snapshotEvents.listen((event) { 
          chatController. progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble()*100;
          });
          uploadTask.whenComplete(() async {
          url = await firebaseStorageRef.getDownloadURL();
          chatController.progress=null;
        DocumentReference documentReferencer =FirebaseFirestore.instance.collection('group_chat_room').doc(docId).collection('chat-message').doc();
        Map<String, dynamic> data = <String, dynamic>{
          "sender_id"  : senderId,
          "sender_name": senderName,
          "sender_profile_image_url" : senderProfileImageUrl,
          "system_message":false,
          "text"  : text,
          "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
          "datetime":DateTime.now(),
          "deleted" : false,
          "images" :url,
          "file": url
        };
      await documentReferencer
      .set(data)
      .whenComplete(() async{
      })
      .catchError((e) {
        //
      });
    });
    }else{
      if(filepath.contains('.jpg')||filepath.contains('.png')){
         final firebaseStorageRef = FirebaseStorage.instance.ref().child("images/$fileName");
          uploadTask = firebaseStorageRef.putFile(File(imageFile.path) , SettableMetadata(contentType: 'images/$fileName'));
          uploadTask.snapshotEvents.listen((event) { 
            chatController. progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble()*100;
          });
          uploadTask.whenComplete(() async {
          url = await firebaseStorageRef.getDownloadURL();
          chatController. progress = null;
            DocumentReference documentReferencer =FirebaseFirestore.instance.collection('group_chat_room').doc(docId).collection('chat-message').doc();
          Map<String, dynamic> data = <String, dynamic>{
            "sender_id"  : senderId,
            "sender_name": senderName,
            "sender_profile_image_url" : senderProfileImageUrl,
            "system_message":false,
            "text"  : text,
            "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
            "datetime":DateTime.now(),
            "deleted" : false,
            "images" :'',
            "file":url
          };
        await documentReferencer.set(data).whenComplete(() async{
      FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"chatCount" :  0 + 1});
        })
        .catchError((e) {
          //
        });
    }); 
      }else{
         final firebaseStorageRef = FirebaseStorage.instance.ref().child("file/files/$fileName");
          File file =File(filepath);
          uploadTask = firebaseStorageRef.putFile(file,
          SettableMetadata(contentType: 'file/files/$fileName')
          );
          uploadTask.snapshotEvents.listen((event) { 
          chatController.progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble()*100;
          });
        uploadTask.whenComplete(() async {
          url = await firebaseStorageRef.getDownloadURL();
          chatController.progress = null;
          DocumentReference documentReferencer =FirebaseFirestore.instance.collection('group_chat_room').doc(docId).collection('chat-message').doc();
          Map<String, dynamic> data = <String, dynamic>{
            "sender_id"  : senderId,
            "sender_name": senderName,
            "sender_profile_image_url" : senderProfileImageUrl,
            "system_message":false,
            "text"  : text,
            "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
            "datetime":DateTime.now(),
            "deleted" : false,
            "images" :'',
            "file":url
          };
        await documentReferencer.set(data).whenComplete(() async{
       })
        .catchError((e) {
          //
        });
    }); 
      }
     
    }
  }

  //getting counter
  static Stream getCounter(docId) {
    try{
      return  FirebaseFirestore.instance.collection('chat').doc(docId).snapshots();
    }
    catch (e){
      rethrow;
    }
  }

  static Stream getcountDetail(docId) {
    try{
    return  FirebaseFirestore.instance.collection('chat').doc(docId).snapshots();
    }
    catch (e){
      rethrow;
    }
  }
  //RESET COUNTER ON TAP TO 0
  static updateCounter(
    String?docId,
    int senderId,
  ) async {
      var splitDoc = docId!.split('-');
      var split1 =splitDoc[0];
      var split2 =splitDoc[1];
      String name1 = '${splitDoc[0]}_unread_count';
      String name2 = '${splitDoc[1]}_unread_count';
      DocumentReference documentReferencer =FirebaseFirestore.instance.collection('chat').doc(docId);
      dynamic data;
      if(senderId.toString()==split1){
        data = <String, dynamic>{
          name2: 0,
        };
      }else if(senderId.toString()==split2){
        data = <String, dynamic>{
          name1: 0,
        };
      }
      await documentReferencer.update(data);
    }
    //Send Message
  static Future<void> sendClientNote({
    String ?docId,
    required String type,
    required String indexId,
    required int senderId,
    required String senderName,
    required String senderProfileImageUrl,
    required String text,
    String? fileUrl,
    String? fileName,
    File? file,
    required bool checkMsgEmpty,
  }) async {
    DocumentReference documentReferencer =  FirebaseFirestore.instance
      .collection("manifestTask")
      .doc(docId) .collection(type.toString()).doc(indexId.toString()).collection('client_notes').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "sender_id"  : senderId,
      "sender_name": senderName,
      "sender_profile_image_url"  : senderProfileImageUrl,
      "system_message":false,
      "text"  : text,
      "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
      "datetime":DateTime.now(),
      "deleted" : false,
      "images" :''
    };
    await documentReferencer
    .set(data)
    .whenComplete(() async{
    })
    .catchError((e) {
      //
    });
  }
   static Future<void> sendTeamNote({
    String ?docId,
    required int senderId,
    required String indexId,
    required String senderName,
    required String senderProfileImageUrl,
    required String text,
    String? fileUrl,
    String? fileName,
    required String type,
    File? file,
    required bool checkMsgEmpty,
  }) async {
     DocumentReference documentReferencer =  FirebaseFirestore.instance
      .collection("manifestTask")
      .doc(docId) .collection(type.toString()).doc(indexId).collection('team_notes').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "sender_id"  : senderId,
      "sender_name": senderName,
      "sender_profile_image_url"  : senderProfileImageUrl,
      "system_message":false,
      "text"  : text,
      "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000,
      "datetime":DateTime.now(),
      "deleted" : false,
      "images" :''
    };
    await documentReferencer
    .set(data)
    .whenComplete(() async{
    })
    .catchError((e) {
      //
    });
  }

   //create group 
  static Future<void> createGroup({
    required String docId,
    required String groupName,
     String ?description,
    String? groupImage,
    String? lastMessage,
    dynamic groupMember
 
  }) async {
    DocumentReference documentReferencer =FirebaseFirestore.instance.collection('groupChatDetail').doc(docId.toString());
    Map<String, dynamic> data = <String, dynamic>{
      "id" : docId, //same as doc id
      "group_name"  : groupName.toString(),
      "description" : description.toString(),
      "group_image"  : '',
      "delete_flg" : false,
      "created_datetime": DateTime.now(),
      "update_datetime": DateTime.now(),
      "last_msg": lastMessage.toString(),
      'group_member':groupMember
    };
    await documentReferencer
    .set(data).then((value) async{
      
        await FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"groupchatCount" :  int.parse(docId) + 1});
    })
    .whenComplete(() {
      Get.back();
      Get.back();
      Get.back();
    })
    .catchError((e) {
      //
    });
  }
  
  // User list
  static Stream getgroupChatlist() {
    try{
      var value = FirebaseFirestore.instance.collection("groupChatDetail")
      .snapshots();
      return value;
    }
    catch (e){
      rethrow;
    }
  }
   //Send Message
 
  
  static Future<void> groupChatlog({
    String ?groupId,
    required int userId,
   
  }) async {
     DocumentReference documentReferencer =  FirebaseFirestore.instance
      .collection("group_chat_logs")
      .doc(groupId).collection('message_read_log').doc(userId.toString());
    Map<String, dynamic> data = <String, dynamic>{
      "group_id": groupId,
      "user_id": userId,
      "unix_timestamp": DateTime.now().toUtc().millisecondsSinceEpoch~/1000
    };
    await documentReferencer
    .set(data)
    .whenComplete(() async{
    })
    .catchError((e) {
      //
    });
  }

   static Stream getgroupchatLog(docId,userId) {
    try{
      var timestamp= FirebaseFirestore.instance.collection('group_chat_logs').doc(docId).collection('message_read_log').doc(userId).snapshots();
      return timestamp;
    }
    catch (e){
      rethrow;
    }
  }
  
  static Future<void> groupUpdate({
     required String docId,
     required List userId,
   }) async {
     DocumentReference documentReferencer =FirebaseFirestore.instance.collection('groupChatDetail').doc(docId.toString());
    Map<String, dynamic> data = <String, dynamic>{
      "update_datetime": DateTime.now(),
      'group_member':FieldValue.arrayUnion(userId)
    };
    await documentReferencer
    .update(data).whenComplete(() {
      Get.back();
      Get.back();
    })
    .catchError((e) {
    });
  }
}
        





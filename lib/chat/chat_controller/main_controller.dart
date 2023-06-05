// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:school_management_app/app/core/dio/dio_client.dart';
import 'package:school_management_app/chat/chat_controller/user_controller.dart';

class MainController extends GetxController{
  final UserController userCon =Get.put(UserController());
  RxBool isLoading = false.obs;
  List countList = [];
  List userNotificationList = [];
  final box= GetStorage();
  var currentDateTime=  DateFormat('MM/dd/yyyy HH:mm:ss').format(DateTime.now());
  RxList vehicleList = [].obs; 
  RxList statusList = [].obs;
  RxList userList = [].obs;
  RxList allCompanyList = [].obs;
  RxList rosterList = [].obs;
  RxList assigneddateList = [].obs;
  RxList assignedAlldateList = [].obs;
  RxList manifestList = [].obs;
  RxList rosterDateList = [].obs;
  bool sidebarOpen = false;
  dynamic startDate;
  dynamic endDate;


  getData() async{
    try{
      isLoading(true);
      QuerySnapshot firebaseData = await FirebaseFirestore.instance.collection('Count').get();
      countList.clear();
      for(var data in firebaseData.docs){
        countList.add(
          {
            "userCount" : data['userCount'],
            "companyCount" : data['companyCount'], 
            "countId" : data['countId'],
            "statusCount" : data['statusCount'],
            "vehicleCount" : data['vehicleCount'],
            "manifestCount" : data['manifestCount'],
            "chatCount" : data['chatCount'],
            "groupchatCount" : data['groupchatCount'],
            "rosterCount" : data['rosterCount'],
            "addressBookCount" : data['addressBookCount'],
          }
        );
      }
      update();
    }catch(e){
      Get.snackbar("An Error Occured!", e.toString());
    } finally{
      isLoading(false);
    }
  }

  getUserNotificationList(userId) async{
    try{
      isLoading(true);
      userNotificationList.clear();
      QuerySnapshot firebaseData = await FirebaseFirestore.instance.collection('userNotification')
      .doc(userId.toString())
      .collection('notificationList')
      .get();
      for(var data in firebaseData.docs){
        userNotificationList.add(
          {
            data["data"]
          }
        );
      }
      update();
    }catch(e){
      Get.snackbar("An Error Occured!", e.toString());
    } finally{
      isLoading(false);
    }
  }

  sendNotification(fcmToken, body, title, user,[withNotification, profileUrl]) async{
    if(withNotification == true){
      for(int i = 0; i < fcmToken.length ; i++){
        var data = {
          "to": fcmToken[i],
          "notification" : {
          "body" : body,
          "priority" : "high",
          "title": title,
          "readStatus" : false
          },
          "data" : {
            "title": title,
            "body" : body,
            "profilePhoto" :"",
            "createdDate" : currentDateTime.toString(),
            "createdAt" : DateTime.now().toString(),
            "createdBy" : "${box.read('firstName')} ${box.read('lastName')}",
            "priority" : "high",
            "sound":"app_sound.wav",
            "bodyText" : "New Announcement assigned",
          }
        };
        dio.post("https://fcm.googleapis.com/fcm/send", data: jsonEncode(data));
        var docRef = FirebaseFirestore.instance.collection("userNotification").doc(user[i].toString()).collection("notificationList").doc();
        docRef.set(data).whenComplete(() async{
          dynamic data;
          DocumentReference documentReferencer = FirebaseFirestore.instance.collection('userNotification').doc(user[i].toString());
          data = <String, dynamic>{
            "red_flag": true,
          };
          await documentReferencer.set(data);
        });
      }
    } else{
        for(int i = 0; i < fcmToken.length ; i++){
          var data = {
            "to": fcmToken[i],
            "notification" : {
              "body" : body,
              "priority" : "high",
              "title": title,
              "readStatus" : false
            },
            "data" : {
              "profilePhoto" : "",
              "createdDate" : currentDateTime.toString(),
              "createdAt" : DateTime.now(),
              "createdBy" : "${box.read('firstName')} ${box.read('lastName')}",
              "priority" : "high",
              "sound":"app_sound.wav",
              "bodyText" : "New Announcement assigned",
            }
          };
        var docRef = FirebaseFirestore.instance.collection("userNotification").doc(user[i].toString()).collection("notificationList").doc();
        docRef.set(data).whenComplete(() async{
          dynamic data;
          DocumentReference documentReferencer = FirebaseFirestore.instance.collection('userNotification').doc(user[i].toString());
          data = <String, dynamic>{
            "red_flag": true,
          };
          await documentReferencer.set(data);
        });
      }
    }
  }

  //Send Chat Notification
  sendChatNotification(fcmToken, body, title,[profilePhoto]) async{
    for(int i = 0; i < fcmToken.length ; i++){
      var data = {
        "to": fcmToken[i],
        "notification" : {
        "body" : body,
        "priority" : "high",
        "title": title,
        "readStatus" : false
        },
        "data" : {
          // "createdDate" : currentDateTime.toString(),
          // "createdBy" : "${box.read('firstName')} ${box.read('lastName')}",
          "profilePhoto" : profilePhoto ?? "",
          "priority" : "high",
          "sound":"app_sound.wav",
          "bodyText" : "New Announcement assigned",
        }
      };
      dioNotification.post("https://fcm.googleapis.com/fcm/send", data: jsonEncode(data));
    }
  }
 

 

  

  

 
 
}
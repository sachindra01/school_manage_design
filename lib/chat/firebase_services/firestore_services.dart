// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FirestoresServices{
  // User list
  static Stream getUserlist() {
    try{
      var value = FirebaseFirestore.instance.collection("UserList")
      .snapshots();
      return value;
    }
    catch (e){
      rethrow;
    }
  }

    // User list
  static getUserId(email) async {
    var box = GetStorage(); 
    try{
      var value = await FirebaseFirestore.instance.collection('userList')
      .where('email', isEqualTo: email)
      .get();
      for(var data in value.docs){
          if(data['email'] == email) {
            box.write('userId',data['userId']);
            box.write('userRole',data['role']);
          }
      }
      // var user = FirebaseFirestore.instance.collection("userList")
      // .where('email', isEqualTo: email)
      // .snapshots()
      // .map((event) {
        
      // print(event);
      // },);
      // print('user');
    }
    catch (e){
      rethrow;
    }
  }


  // Creating User
  static Future<void> addUser(emails,userId,userName,phoneNumber,role,companyName,isEnabled,note,url) async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? fcm = await messaging.getToken();
      //firebase firestore
      Map<String, dynamic> data = {
        'userId':userId,
        "userName" : userName.toString().trim().capitalize,
        "email" : emails.toString().trim(),
        "role" : role.toString().trim(),
        "companyName" :companyName.toString().trim(),
        "isEnabled" : isEnabled,
        "isNotification" : true,
        "isChatNotification" : true,
        "fcmAndroid" : fcm,
        "fcmIos" : "",
        "fcmWeb" : "",
        "profilePic" : url,
      };
      await FirebaseFirestore.instance.collection("UserList").doc(userId.toString()).set(data)
      .then((value) async {
        await FirebaseFirestore.instance.collection("Count").doc("Count-ID").update({"userCount" :  userId + 1});
        }
      );
        
    } on FirebaseException catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString(),
        backgroundColor: const Color.fromARGB(126, 255, 255, 255));
    }
  }

   //Update User
  static Future<void>  updateUser(emails,users,userId,firstName,lastName,phoneNumber,role,companyName,isEnabled,note, url) async {
    try {
      Map<String, dynamic> data = {
        "firstName" : firstName.toString().trim().capitalize,
        "lastName" : lastName.toString().trim().capitalize,
        "email" : emails.toString().trim(),
        "phoneNumber" : phoneNumber.toString().trim(),
        "role" : role.toString().trim(),
        "companyName" :companyName.toString().trim(),
        "isEnabled" : isEnabled,
        "note" : note.toString().toLowerCase(),
        "profilePic" : url.toString()
      };
      await FirebaseFirestore.instance.collection("UserList").doc(userId.toString()).update(data)
      .then((value) => Get.back())
      .then((value) => Get.back())
      .then((value) => Get.snackbar(
        "Success", "User Updated Succesfully",
        backgroundColor: const Color.fromARGB(160, 105, 240, 175)
        )
      );
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  //Delete User from firestore
  static Future<void> deleteUser(userId) async{
    try{
      await FirebaseFirestore.instance
        .collection("UserList")
        .doc(userId.toString())
        .delete()
        .then((value) => Get.back())
        .then((value) => Get.back())
        .then((value) => Get.snackbar(
        "Deleted", "User Deleted Succesfully",
        )
      );
    } on FirebaseException catch (e){
      debugPrint(e.toString());
    }
  }
}
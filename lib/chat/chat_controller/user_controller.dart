import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  RxBool isLoading = false.obs;
  List userList = [];
  List clientCount = [];
  List assignedToList = [];
  List leadList = [];
  List userNotificationStatus = [];
  dynamic manifestData ;
  dynamic rosterData ;
  dynamic lead;

  //list of bool value in index for checkbox
  List<bool>? isClientChecked; 
  List<bool>? isAssignedTo;
  List<bool>? isLead;

  getData() async{
    try{
      isLoading(true);
      QuerySnapshot firebaseData = await FirebaseFirestore.instance.collection('UserList').get();
      userList.clear();
      for(var data in firebaseData.docs){
        userList.add(
          {
            "userId" : data['userId'],
            "userName" :data['userName'],
            "email" :data['email'],
            "role" :data['role'],
            "companyName" :data['companyName'],
            "fcmAndroid" : data['fcmAndroid'],
            "fcmIos" : data['fcmIos'],
            "fcmWeb" : data['fcmWeb'],
            "isEnabled": data['isEnabled'],
            "isNotification" : data['isNotification'],
            "isChatNotification" : data['isChatNotification'],
            "profilePic" : data['profilePic']
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

 


  

  

 
  
  

 
}
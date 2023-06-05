import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:school_management_app/main.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin localNotificationPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialize local notification and creating channel
  static void initialize(BuildContext context){
    //local notification initialization
    final InitializationSettings initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => {
          1,
          "IOS Title", 
          "IOS Body", 
          {
            "to" : "my_fcm_token",
            "notification" : {
            "body" : "sample body",
            "OrganizationId":"2",
            "content_available" : true,
            "mutable_content": true,
            "priority" : "high",
            "subtitle":"sample sub-title",
            "Title":"hello"
            },
            "data" : {
              "msgBody" : "Body of your Notification",
              "msgTitle": "Title of your Notification",
              "msgId": "000001",
              "data" : "This is sample payloadData"
            }
          }
          },
      ),
    );
    localNotificationPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async{
      if(payload != null){
        navigatorKey.currentState!.pushNamed(payload);
      }
    });
  }

  //channel
  //to display on foreground and create a channel
  static void display(RemoteMessage message) async{
    try {
      if(message.data["profilePhoto"] == ""){
        final id = DateTime.now().millisecondsSinceEpoch ~/1000;
        NotificationDetails notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
            "onsite", //channelId
            "channel onsite", //channelName
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: "Sd",
            badgeNumber: 2,
            threadIdentifier: "IOs",
            subtitle: "IOStrue",)
        );
        
        await localNotificationPlugin.show(
          id,
          message.notification!.title, 
          message.notification!.body, 
          notificationDetails,
          payload: message.data['route'],
        );
      } else{
        final http.Response response = await http.get(Uri.parse(message.data["profilePhoto"]));
        final id = DateTime.now().millisecondsSinceEpoch ~/1000;
        NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "onsite", //channelId
            "channel onsite", //channelName
            importance: Importance.max,
            priority: Priority.high,
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)),
          ),
          iOS: const IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: "Sd",
            badgeNumber: 2,
            threadIdentifier: "IOs",
            subtitle: "IOStrue",)
        );
        await localNotificationPlugin.show(
          id,
          message.notification!.title, 
          message.notification!.body, 
          notificationDetails,
          payload: message.data['route'],
        );
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


  //For Ios
  notificationInitialization() async {
    if (Platform.isIOS) {
      iosPermissionHandler();
    }
    _requestPermissions();
    String? fcm = await messaging.getToken();
    debugPrint('FCM Token => $fcm');
  }

  iosPermissionHandler() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  void _requestPermissions() {
    localNotificationPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    localNotificationPlugin.resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
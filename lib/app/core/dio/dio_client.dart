import 'package:dio/dio.dart';
import 'interceptor/logging_interceptor.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://school.learninstep.com/',
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    receiveDataWhenStatusError: true,
    // connectTimeout: 100 * 1000, // 60 seconds
    // receiveTimeout: 100 * 1000),
  ),
)..interceptors.add(Logging());

final dioNotification = Dio(
  BaseOptions(
    baseUrl: 'https://fcm.googleapis.com/',
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'AAAATVASEEI:APA91bGe2Ezl4VYXqfGagAEszpEBJDg7Zf_Nev_glScaAOsSsXFDuhofHZ2Mfqmnody7a8rexQq7KfZI-lgcxYDPDwR4FpN0ckJMEAX1IIv4FSDGP9d0A-SQ371EisQQhodH0pYqOSjG'
    },
    receiveDataWhenStatusError: true,
    // connectTimeout: 100 * 1000, // 60 seconds
    // receiveTimeout: 100 * 1000),
  ),
)..interceptors.add(Logging());

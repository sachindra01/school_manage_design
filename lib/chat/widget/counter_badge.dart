import 'package:flutter/material.dart';
import 'package:school_management_app/chat/chat_model/message_model.dart';
import 'package:school_management_app/chat/firebase_services/firebase_chat_services.dart';


class CounterBadge extends StatefulWidget {
  const CounterBadge({super.key, this.id, this.userId});
  final dynamic id;
  final dynamic userId;


  @override
  State<CounterBadge> createState() => _CounterBadgeState();
}

class _CounterBadgeState extends State<CounterBadge> {
  var counter = 0;
  dynamic myTimeStamp;
  
  @override
  void initState() {
    super.initState();
  }
   
  @override
  Widget build(BuildContext context) {
    return StreamBuilder <List<Message>>(
      stream:FirebaseChatServices.getGroupmessageList(widget.id.toString()),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return  const SizedBox(
          );
        } else {
          var messageList = snapshot.data;
          return StreamBuilder(
            stream:FirebaseChatServices.getgroupchatLog(widget.id,widget.userId.toString()), 
            builder: (BuildContext context, AsyncSnapshot<dynamic> timeSnapshot) {  
              if (!timeSnapshot.hasData) {
                return  const SizedBox(
                );
              } 
              else {
                counter =0;
                for (var i = 0; i < messageList!.length; i++) {
                  if ((int.parse(messageList[i].unixTimestamp.toString())) > timeSnapshot.data['unix_timestamp']){
                    counter=counter+1;
                  }
                }
                return counter == 0 
                ? const SizedBox()
                : ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 25,
                    width: 25,
                    color: Colors.red,
                    child:   Center(
                      child: Text(
                        counter.toString(),
                        style: const TextStyle(fontSize: 13, color: Colors.white,),
                        textAlign:TextAlign.center,
                      )
                    ),
                  ),
                );
              }
            }
          );
        }
      }
    );
  }
}
// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_management_app/chat/chat_controller/chat_controller.dart';

class GroupListTile extends StatefulWidget {
  final String name, role;
  final int? numberOfMessage;
  final int? id,userId;
  const GroupListTile({super.key, required this.name, required this.role, this.numberOfMessage, this.id, this.userId});

  @override
  State<GroupListTile> createState() => _GroupListTileState();
}

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }  

class _GroupListTileState extends State<GroupListTile> {
  final ChatController _chatController =Get.put(ChatController());
  final box = GetStorage();
  var userId;
  var dId;
  bool showCounter = false;

  String _selectedRadioBtnVal = '1';

  @override
  void initState() {
  initalize();
    super.initState();
  }
  initalize()async{
    setState(() {
     dId =_chatController.createdocId(
        widget.id,widget.userId
      );
    });
   
  }
  _handleChange(String? value) {
      setState(() { 
        if(value==null){
          setState(() {
          _selectedRadioBtnVal = '';
          _chatController.addUser.remove(widget.id.toString());
          });
        }else{
          _selectedRadioBtnVal = value;
          for (var element in _chatController.addUser) {
            if(_selectedRadioBtnVal==element){
              setState(() {
                _selectedRadioBtnVal = '';
                _chatController.addUser.remove(widget.id.toString());
              });
            }
          }
          setState(() {
          _chatController.addUser.add(value);  
          });
        }
      });  
      debugPrint('Users IN Group: ${_chatController.addUser}');       
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _handleChange(widget.id.toString());
      },
      child: InkWell(
        child: Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.white
          ),
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(widget.name,  
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5.0,),
                  Text(widget.role, 
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 139, 139, 139)),
                  )
                ],
              ),
               ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    height: 48,
                    width: 28,
                    child: 
                    Radio(  
                      value: widget.id.toString(),  
                      groupValue: _selectedRadioBtnVal,
                      toggleable: true,  
                      onChanged:_handleChange
                    
                    ),
                ),
              )     
            ],
          ),
        ),
      ),
    );
  }
}
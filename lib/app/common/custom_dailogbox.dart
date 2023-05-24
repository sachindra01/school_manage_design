import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/helper/auth_manager.dart';
import 'package:school_management_app/app/modules/auth/views/login_screen.dart';

  final AuthenticationManager authManager=AuthenticationManager();
customDialogBox(context,){
  return showDialog(
    context: context, 
    builder: (context){
        return alert(context);
      },
    );
    
}
 okButton(context){
  return TextButton(
      child: const Text("Leave now",style: TextStyle(color: Colors.red),),
      onPressed:(){
       bool sucess= authManager.logOut();
       if(sucess==true){
        Get.off(()=>const LoginScreen());
       }
      } ,
    );}

    Widget nopeButton(context){
      return TextButton(
      child: const Text("Stay here"),
      onPressed: () { Navigator.pop(context); },
    );}

    AlertDialog alert(context){
      return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32.0)
              )
            ),
        title: const Text("Exit"),
        content: const Text("Are you sure you want to leave?"),
        actions: [
          nopeButton(context),
          okButton(context),
        ],
      );
    }



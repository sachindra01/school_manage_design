import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/read_write.dart';
import 'package:school_management_app/app/helper/auth_manager.dart';
import 'package:school_management_app/app/modules/auth/auth_contoller.dart';
import 'package:school_management_app/app/modules/auth/views/login_screen.dart';

  final AuthenticationManager authManager=AuthenticationManager();
    final AuthController _authController =Get.put(AuthController());
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
      onPressed:()async{
     var removed=  remove('apiToken');
       if(removed==null){
       await _authController.canUseBiometric();
        Get.to(()=>const LoginScreen());
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



import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/style.dart';

defaultAppbar(context,{Widget? title, List<Widget>? action, autoImplying,Widget ?leadingIcon,ontap}) {
  return AppBar(
    elevation: 0.0,
    leading:Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap:ontap?? (){
          Navigator.of(context).pop();
        },
        child: leadingIcon??
        Container(
           decoration: BoxDecoration(
            boxShadow: const [
               BoxShadow(
                  color: Colors.grey, // Change color of the shadow
                  blurRadius: 0.0,
                  spreadRadius: 0.1,
                  offset: Offset(0.2, 0.2)
                )
            ],
            borderRadius: BorderRadius.circular(10), // <= No more error here :)
            color: lGrey,
            ),
            child: const Icon(Icons.arrow_back_ios,color: primaryColor,size: 20,),
        ),
      ),
    ),
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      automaticallyImplyLeading: autoImplying ?? true,
      centerTitle: true,
      actions: action,
      flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            // colors: [Colors.deepPurple, Colors.purple],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(220, 46, 36, 72),
            // Color.fromARGB(255, 230, 149, 45),
            Color.fromARGB(255, 223, 104, 144),
              ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          ),
        ), 
      title: title ??
        Center(
          child: CircleAvatar(
            radius: 25,
            backgroundColor: lBlack,
            child: Padding(
              padding: const EdgeInsets.all(2), // Border radius
              child:
                  ClipOval(child: Image.asset('assets/img/logo.jpg')),
            ),
          ),
        ),
      );
}

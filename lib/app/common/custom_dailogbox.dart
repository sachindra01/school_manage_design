import 'package:flutter/material.dart';


customDialogBox(context, title, onYes, onNo,[onOk]){
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
      onPressed: () {Navigator.pop(context);  },
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



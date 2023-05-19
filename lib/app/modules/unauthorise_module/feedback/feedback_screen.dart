import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/custom_textfield.dart';
import 'package:school_management_app/app/common/style.dart';

class Feedbackform extends StatefulWidget {
  const Feedbackform({super.key});

  @override
  State<Feedbackform> createState() => _FeedbackformState();
}

class _FeedbackformState extends State<Feedbackform> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController name = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController feedback = TextEditingController();
  final FocusNode _passfocusNode = FocusNode();
  final FocusNode _emailfocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: defaultAppbar(
        context,
        title: const Text(
          'Notice Board',
          style: TextStyle(
            color:  lWhite, 
            fontSize: 22.0, 
            fontWeight: FontWeight.w700
          ),
        ),
     ),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    prefixIcon: const Icon(
                      LineAwesomeIcons.envelope,
                      color: primaryColor,
                    ),
                    autoFocus: false,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    context: context,
                    focusNode: _emailfocusNode,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    controller: name,
                    textCapitalization: TextCapitalization.none,
                    borderColor: const Color(0xFFD5DDE0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    borderRadius: 15,
                    fillColor: const Color(0xFFF7F8F9),
                    hintStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),

                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    prefixIcon: const Icon(
                      LineAwesomeIcons.lock,
                      color: primaryColor,
                    ),
                    autoFocus: false,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    context: context,
                    focusNode: _passfocusNode,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    controller: contactNumber,
                    textCapitalization: TextCapitalization.none,
                    borderColor: const Color(0xFFD5DDE0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    borderRadius: 15,
                    fillColor: const Color(0xFFF7F8F9),
                    hintStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    hintText: 'password',
                  ),
                  const SizedBox(height: 35),
                    CustomTextField(
                    autoFocus: false,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    context: context,
                    focusNode: _passfocusNode,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    controller: email,
                    textCapitalization: TextCapitalization.none,
                    borderColor: const Color(0xFFD5DDE0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    borderRadius: 15,
                    fillColor: const Color(0xFFF7F8F9),
                  ),
                   const SizedBox(height: 35),
                  CustomTextField(
                    maxLines: 10,
                    maxLength: 300,
                    autoFocus: false,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    context: context,
                    focusNode: _passfocusNode,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    controller: email,
                    textCapitalization: TextCapitalization.none,
                    borderColor: const Color(0xFFD5DDE0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    borderRadius: 15,
                    fillColor: const Color(0xFFF7F8F9),
                  ),
                ]
            ),
          ),

        ],
      ),
    );
  }
}
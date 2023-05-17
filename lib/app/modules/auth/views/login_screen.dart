// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_app/app/common/carousel_slider.dart';
import 'package:school_management_app/app/common/custom_textfield.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/common/submit_button.dart';
import 'package:school_management_app/app/modules/home/views/home_screen.dart';

// ignore: unused_import

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  final FocusNode _passfocusNode = FocusNode();
  final FocusNode _emailfocusNode = FocusNode();
  final bool _isLoading = false;
  @override
  void dispose() {
    emailCtr.dispose();
    passwordCtr.dispose();
    _passfocusNode.dispose();
    _emailfocusNode.dispose();

    super.dispose();
  }

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            // alignment: Alignment.center,
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //   child: Container(
                  //     padding: EdgeInsets.all(8), // Border width
                  //     decoration: BoxDecoration(
                  //         color: lBlack, borderRadius: borderRadius),
                  //     child: ClipRRect(
                  //       borderRadius: borderRadius,
                  //       child: SizedBox.fromSize(
                  //         size: const Size.fromRadius(100), // Image radius
                  //         child: Image.asset('assets/img/logo.jpg'),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: lBlack,
                      child: Padding(
                        padding: const EdgeInsets.all(8), // Border radius
                        child:
                            ClipOval(child: Image.asset('assets/img/logo.jpg')),
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     'assets/img/logo.jpg',
                  //     width: 200,
                  //     height: 200,
                  //   ),
                  // ),
                  const SizedBox(height: 37.0),
                  const Text(
                    "LOGIN",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        color: lWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            autoFocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              final regex = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (value!.isEmpty) {
                                return 'Fill empty field !';
                              } else if (!regex.hasMatch(value)) {
                                return 'Invalid Email.!';
                              } else {
                                return null;
                              }
                            },
                            context: context,
                            focusNode: _emailfocusNode,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            controller: emailCtr,
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
                            hintText: 'Email',
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            autoFocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Fill empty field !';
                              } else if (value.isEmpty) {
                                return 'Invalid Email.!';
                              } else {
                                return null;
                              }
                            },
                            context: context,
                            focusNode: _passfocusNode,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            controller: passwordCtr,
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
                        ]),
                  ),
                  SizedBox(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                              backgroundColor: white,
                            ),
                          )
                        : CustomButton(
                            verticalPadding: 15,
                            buttonText: 'Log In',
                            textColor: primaryColor,
                            buttonColor: lWhite,
                            borderRadiusGeometry: BorderRadius.circular(40),
                            onPressed: () async {
                              Get.to(()=>const HomeScreen());
                              FocusManager.instance.primaryFocus?.unfocus();
                              // setState(() {
                              //   _isLoading = true;
                              // });
                              // if (formKey.currentState!.validate()) {}
                            

                              // setState(() {
                              //   _isLoading = false;
                              // });
                            },
                            trailingIcon: const SizedBox(),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  biometric(context),
                  const SizedBox(height: 30),
                  bannerCarouseSlider(context,150.0,300.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  biometric(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: lGrey),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: const Icon(Icons.fingerprint,
                  color: Colors.green, size: 40.0),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

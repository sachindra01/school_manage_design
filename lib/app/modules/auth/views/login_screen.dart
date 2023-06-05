// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:school_management_app/app/common/custom_textfield.dart';
import 'package:school_management_app/app/common/gradient_button.dart';
import 'package:school_management_app/app/common/loading_widget.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/auth/auth_contoller.dart';

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
  final AuthController _authController =Get.put(AuthController());
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
  intialize();
    super.initState();
  }
  intialize(){
    setState(() {
        _authController.canUseBiometric();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            decoration:const BoxDecoration(
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
            
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            // alignment: Alignment.center,
            child: GetBuilder(
              init: AuthController(),
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: lBlack,
                        child: Padding(
                          padding: const EdgeInsets.all(8), // Border radius
                          child:
                              ClipOval(child: Image.asset('assets/img/logo.jpg')),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'CODENT ACADEMIC SOFTWARE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: lWhite,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 37.0),
                    Container(
                       decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 8, color: black, offset: Offset(2, 2))
                          ]
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
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
                                      obscureText: obscureText,
                                      suffixIcon: InkWell(
                                        onTap: (() {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        }),
                                        child: Icon(
                                          obscureText == true
                                              ? LineAwesomeIcons.eye_slash
                                              : LineAwesomeIcons.eye,
                                          color: primaryColor,
                                        ),
                                      ),
                                      prefixIcon: const Icon(
                                        LineAwesomeIcons.lock,
                                        color: primaryColor,
                                      ),
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
                            // SizedBox(
                            //   child: _isLoading
                            //       ? const Center(
                            //           child: CircularProgressIndicator(
                            //             color: primaryColor,
                            //             backgroundColor: white,
                            //           ),
                            //         )
                            //       : CustomButton(
                            //           verticalPadding: 15,
                            //           buttonText: 'Log In',
                            //           textColor: lWhite,
                            //           buttonColor: primaryColor,
                            //           borderRadiusGeometry:
                            //               BorderRadius.circular(40),
                            //           onPressed: () async {
                            //             Get.to(() => const HomeScreen());
                            //             FocusManager.instance.primaryFocus
                            //                 ?.unfocus();
                            //             // setState(() {
                            //             //   _isLoading = true;
                            //             // });
                            //             // if (formKey.currentState!.validate()) {}

                            //             // setState(() {
                            //             //   _isLoading = false;
                            //             // });
                            //           },
                            //           trailingIcon: const SizedBox(),
                            //         ),
                            // ),
                            Obx(()=> 
                           _authController.isLoading.value
                           ? loadingWidget()
                           : GradientButton(
                                text: "Login".tr,
                                height: 40.h,
                                width: 200.w,
                                borderRadius: 100.r,
                                onPressed: ()async{
                                 _authController.getLogin(emailCtr.text, passwordCtr.text);
                                }
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            bioMetrics(context),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // bannerCarouseSlider(context, 150.0, 300.0),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  containerTile() {
    return Center(
      child: Container(
        height: 80,
        width: 300,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            color: lWhite),
        child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Card(
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: primaryColor.withOpacity(0.2),
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3.0,
                            child: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  LineAwesomeIcons.building_1,
                                  color: lWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'About-us',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 10,
                              color: lBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  
  bioMetrics(context) {
    return GetBuilder(
      init: AuthController(),
      builder: (context) {
        return Visibility(
          visible: _authController.canUseBiometic,
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  height: 100.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lGrey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: const Icon(
                    Icons.fingerprint,
                    size: 80.0,
                  ),
                ),
                onTap: () async => await _authController.authenticate(context),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Use Biometrics to log in',
                style: TextStyle(
                  color: greyColor
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
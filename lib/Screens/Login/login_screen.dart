import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:kava_beats_app/Screens/Home%20Screen/home_screen.dart';
import 'package:kava_beats_app/Screens/signup/signup.dart';
import 'package:kava_beats_app/Widgets/text_fields.dart';
import 'package:kava_beats_app/controller/auth_controller.dart';
import 'package:kava_beats_app/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPass = true;
  FocusNode emailFocusNode = FocusNode();
  FocusNode pasFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              height: height,
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/app_logo.png",
                          // height: 170,
                          width: 170,
                        )),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Kavoon",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  "Enter your email and password for login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        customInputField(
                          email,
                          emailFocusNode,
                          "Email",
                          MultiValidator([
                            authController.requiredValidator,
                            authController.emailValidator,
                          ]),
                        ),
                        SizedBox(height: 20.0),
                        customInputField(
                            password,
                            pasFocusNode,
                            "Password",
                            MultiValidator([
                              authController.requiredValidator,
                            ]),
                            isPassword: isPass, onPressed: () {
                          setState(() {
                            isPass = !isPass;
                          });
                        }),
                      ],
                    ),
                    Column(
                      children: [
                        Obx(
                          () => authController.loading.value
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : SizedBox(
                                  height: 50,
                                  width: width * 0.85,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          AuthServices.signIn(
                                              context,
                                              email.text.toString(),
                                              password.text.toString());
                                        }
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: "Kavoon",
                                            fontWeight: FontWeight.normal),
                                      )),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "if you don't have account? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto",
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                              },
                              child: Text(
                                "SingUp",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

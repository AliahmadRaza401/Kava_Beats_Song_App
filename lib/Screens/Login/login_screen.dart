// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:kava_beats_app/Screens/Home%20Screen/home_screen.dart';
// import 'package:kava_beats_app/Widgets/text_fields.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   bool isTermsConditions = false;

//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       backgroundColor: Theme.of(context).backgroundColor,
//       appBar: AppBar(
//         elevation: Theme.of(context).appBarTheme.elevation,
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         title: const Text(
//           "Login",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: height * 0.25,
//                     ),
//                     textField(
//                       context: context,
//                       lable: "Email",
//                       hint: "Email",
//                       icon: CupertinoIcons.mail,
//                       controller: email,
//                       inputType: TextInputType.emailAddress,
//                     ),
//                     passwordfield(
//                         controller: password,
//                         hint: "Password",
//                         lable: "Password"),
//                     SizedBox(
//                       height: height * 0.08,
//                     ),
//                     SizedBox(
//                       height: 50,
//                       width: width * 0.85,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                           ),
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const HomeScreen()));
//                           },
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(color: Colors.black, fontSize: 16),
//                           )),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

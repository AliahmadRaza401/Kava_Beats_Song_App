import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:kava_beats_app/Screens/Home%20Screen/home_screen.dart';
import 'package:kava_beats_app/Screens/Login/login_screen.dart';
import 'package:kava_beats_app/Widgets/app_toast.dart';
import 'package:kava_beats_app/Widgets/widgets.dart';
import 'package:kava_beats_app/controller/auth_controller.dart';
import 'package:page_transition/page_transition.dart';

import 'shearedpref_service.dart';

class AuthServices {
  static var errorMessage;

  //SignIn
  static signIn(BuildContext context, String email, String password) async {
    final auth = FirebaseAuth.instance;
    AuthController authController = Get.put(AuthController());
    authController.updateLoading(true);

    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              log('User Side '),
              ShearedprefService.setUserTpe('user'),
              ShearedprefService.setUserIDStore(uid.user!.uid),
              ShearedprefService.setUserLoggedIn(true),
              ShearedprefService.setuseremail(email),
              AppRoutes.pushAndRemoveUntil(
                context,
                const HomeScreen(),
              ),
              AppToast('LogIn Success', false),
              authController.updateLoading(false),
            })
        .catchError((e) {
      String errorMessage = "An undefined Error happened.";

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case "invalid-email":
            errorMessage = "Your email address is invalid";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          case "email-already-in-use":
            errorMessage =
                "The email address is already in use by another account.";
            break;
          default:
            errorMessage = "Oops! Your email password is invalid";
        }
      }

      authController.updateLoading(false);
      AppToast("$errorMessage", false);
    });
  }

  // SignUp-----------------------------------------
  static Future signUp(
    BuildContext context,
    String email,
    String pass,
  ) async {
    final _auth = FirebaseAuth.instance;
    AuthController authController = Get.put(AuthController());

    authController.updateLoading(true);

    print("User Creating_________");

    await _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) => {
              print("User Created_________"),
              authController.updateLoading(false),
              AppRoutes.pop(context),
              AppToast('User Created Successfully', true),
            })
        .catchError((e) {
      print('catchError e: $e');

      String errorMessage = "An undefined Error happened.";

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case "invalid-email":
            errorMessage = "Your email address is invalid";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          case "email-already-in-use":
            errorMessage =
                "The email address is already in use by another account.";
            break;
          default:
            errorMessage = "Oops! Something wrong try later";
        }
      }

      authController.updateLoading(false);
      AppToast("$errorMessage", false);
    });
  }

  // static getUserFromGoogle(BuildContext context) async {
  //   try {
  //     print("Google SignIn________");
  //     FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //     User? user;

  //     final GoogleSignIn googleSignIn = GoogleSignIn();

  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //     print("Google SignIn________1");

  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //       print("Google SignIn________2");

  //       try {
  //         final UserCredential userCredential =
  //             await firebaseAuth.signInWithCredential(credential);
  //         print("Google SignIn________3");

  //         user = userCredential.user;
  //         debugPrint('user:______ $user');
  //         AppRoutes.pushAndRemoveUntil(
  //             context, PageTransitionType.fade, Login());
  //       } on FirebaseAuthException catch (e) {
  //         if (e.code == 'account-exists-with-different-credential') {
  //           // KSnackBar().errorSnackBar("The account already exists with a different credential");
  //         } else if (e.code == 'invalid-credential') {
  //           // KSnackBar().errorSnackBar("Error occurred while accessing credentials. Try again.");
  //         }
  //         return "error";
  //       } catch (e) {
  //         // KSnackBar().errorSnackBar("Error occurred using Google Sign In. Try again.");
  //         return "error";
  //       }
  //     } else {
  //       print("Google SignIn________error");

  //       return "error";
  //     }
  //   } catch (e) {
  //     print("catch error: $e");
  //     // KSnackBar().errorSnackBar("Error occurred using Google Sign In. Try again.");
  //     return "error";
  //   }
  // }

// SignOut
  static Future signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      ShearedprefService.setUserLoggedIn(false);
      ShearedprefService.setUserTpe('');
      ShearedprefService.setuseremail('');
      AppRoutes.pushAndRemoveUntil(
        context,
        const LoginScreen(),
      );
    });
  }

  //SignIn
  static passwordChange(BuildContext context, String password) async {
    final auth = FirebaseAuth.instance;
    AuthController authController = Get.put(AuthController());

    authController.updateLoading(true);
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(password)
          .then((value) {
        signOut(context);
        AppToast('Password Change Successfully', false);
        authController.updateLoading(false);
        AppRoutes.pushAndRemoveUntil(
          context,
          const LoginScreen(),
        );
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address is invalid.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "your password or email address is invalid";
      }
      authController.updateLoading(false);
      log('Error = $error');
      // // GeneralDialogs.showOopsDialog(context, errorMessage);
      AppToast("UnAuthorized", false);

      return "false";
    }
  }

  static Future deleteUser(
    context,
  ) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      User user = await _auth.currentUser!;
      user.delete();

      // AuthCredential credentials =
      //     EmailAuthProvider.credential(email: email, password: password);
      // print(user);
      // var result = await user.reauthenticateWithCredential(credentials);

      ShearedprefService.setUserLoggedIn(false);
      ShearedprefService.setUserTpe('');
      AppRoutes.pushAndRemoveUntil(
        context,
        const LoginScreen(),
      );
      AppToast("Your account is permanently deleted Successfully", false);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // static postDetailsToFirestore(
  //     BuildContext context,
  //     fullName,
  //     email,
  //     password,
  //     mobileNumber,
  //     dp,
  //     vDp,
  //     vehicleCompany,
  //     vehicleNumber,
  //     vehicleRegNumber,
  //     vehicleDesign,
  //     vehicleChassisNumber) async {
  //   final _auth = FirebaseAuth.instance;
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;
  //   AuthProvider _authProvider =
  //       Provider.of<AuthProvider>(context, listen: false);

  //   var userImage =
  //       await FirebaseServices.imageUpload(dp, email.toString(), context);
  //   var vehicleImage =
  //       await FirebaseServices.imageUpload(vDp, email.toString(), context);
  //   DriverModel driverModel = DriverModel(
  //     fullName: fullName,
  //     email: email,
  //     password: password,
  //     mobileNumber: mobileNumber,
  //     dp: userImage.toString(),
  //     vDp: vehicleImage.toString(),
  //     vehicleCompany: vehicleCompany,
  //     vehicleNumber: vehicleNumber,
  //     vehicleRegNumber: vehicleRegNumber,
  //     vehicleDesign: vehicleDesign,
  //     vehicleChassisNumber: vehicleChassisNumber,
  //     orderCount: 0,
  //     status: 'pending',
  //     wallet: 0,
  //     level: 1,
  //   );

  //   await firebaseFirestore.collection("drivers").doc(user!.uid).set({
  //     'id': user.uid,
  //     'fullName': fullName,
  //     'email': email,
  //     'password': password,
  //     'mobileNumber': mobileNumber,
  //     'dp': userImage.toString(),
  //     'vDp': vehicleImage.toString(),
  //     'vehicleCompany': vehicleCompany,
  //     'vehicleNumber': vehicleNumber,
  //     'vehicleRegNumber': vehicleRegNumber,
  //     'vehicleDesign': vehicleDesign,
  //     'vehicleChassisNumber': vehicleChassisNumber,
  //     'rating': 5.0,
  //     'level': 1,
  //     'wallet': 0,
  //     'orderCount': 0,
  //     'status': "pending",
  //     'createdAt': DateTime.now(),
  //   }).then((value) {
  //     authController.updateLoading(false);
  //     showBottomSheetForDriver(context);

  //     // AppRoutes.push(context, LoginPage());
  //     _authProvider.carDesignController.clear();
  //     _authProvider.carDesignController.clear();
  //     _authProvider.chassisNumberController.clear();
  //     _authProvider.companyController.clear();
  //     _authProvider.emailController.clear();
  //     _authProvider.engineController.clear();
  //     _authProvider.nameController.clear();
  //     _authProvider.passwordController.clear();
  //     _authProvider.phoneNumberController.clear();
  //     _authProvider.pinCodeController.clear();
  //     _authProvider.registrationNumberController.clear();

  //     MyMotionToast.success(
  //       context,
  //       "Success".tr,
  //       'Account created successfully :) '.tr,
  //     );
  //   }).catchError((e) {
  //     print('e: $e');
  //     MyMotionToast.error(
  //       context,
  //       "Oops!".tr,
  //       'Some thing went wrong Please try again later'.tr,
  //     );
  //   });
  // }
}

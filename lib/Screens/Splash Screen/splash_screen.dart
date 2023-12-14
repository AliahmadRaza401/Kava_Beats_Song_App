import 'package:flutter/material.dart';
import 'package:kava_beats_app/Constants/colors.dart';
import 'package:kava_beats_app/Screens/Bottom%20Navbar/bottom_navbar.dart';
import 'package:kava_beats_app/Screens/Home%20Screen/home_screen.dart';
import 'package:kava_beats_app/Screens/Login/login_screen.dart';
import 'package:kava_beats_app/Widgets/widgets.dart';
import 'package:kava_beats_app/services/shearedpref_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => isAnimate = true);
    });

    timer();
  }

  timer() async {
    var userLoggedIn = await ShearedprefService.getUserLoggedIn();
    print('userLoggedIn: ${userLoggedIn}');
    Future.delayed(const Duration(seconds: 3), () {
      if (userLoggedIn == true) {
        AppRoutes.pushAndRemoveUntil(context, HomeScreen());
      } else {
        AppRoutes.pushAndRemoveUntil(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          // AnimatedPositioned(
          //   // top: height * 0.19,
          //   left: 110,
          //   right: 110,
          //   top: isAnimate ? height * 0.43 : height * 0.25,
          //   duration: const Duration(seconds: 2),
          //   curve: Curves.easeIn,
          //   child: Card(
          //     margin: EdgeInsets.zero,
          //     elevation: 50,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(5)),
          //     child: Container(
          //         height: 110,
          //         width: 110,
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(5)),
          //         child: Image.asset("assets/images/app_logo.png")),
          //   ),
          // ),
          // Align(
          //   alignment: AlignmentDirectional.center,
          //   child: Padding(
          //     padding: const EdgeInsets.all(80),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).splashColor,
          //         shape: BoxShape.circle
          //       ),
          //       child: Center(child: Text("Kava Beats",style: TextStyle(fontFamily: "Kavoon",color: Theme.of(context).toggleableActiveColor,fontSize: 30,fontWeight: FontWeight.bold),)),
          //     ),
          //   ),
          // ),
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/app_logo.png",
                height: 170,
                width: 170,
              )),
          AnimatedPositioned(
              left: 1,
              right: 1,
              bottom: isAnimate ? 30 : -20,
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              child: const Center(
                child: Text(
                  "Kava Beats",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

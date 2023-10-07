import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kava_beats_app/Constants/colors.dart';
import 'package:kava_beats_app/Screens/Contact%20Us/contact_us_screen.dart';
import 'package:kava_beats_app/Widgets/theme_toggle_button.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(0)),
        child: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          width: width * 0.75,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryClr,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    // CircleAvatar(
                    //   radius: 50,
                    //   backgroundImage: drawerPhoto,
                    // ),
                    Text(
                      "Kava Beats",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Kavoon"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: primaryClr,
                ),
                title: const Text('Home', style: TextStyle(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.feedback_rounded,
                  color: primaryClr,
                ),
                title: const Text('Feedback', style: TextStyle(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: primaryClr,
                ),
                title: const Text('Share', style: TextStyle(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                  Share.share("com.example.kava_beats");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.contact_phone,
                  color: primaryClr,
                ),
                title: const Text('Contact Us', style: TextStyle(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const ContactUsScreen(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.moon_stars_fill,
                  color: primaryClr,
                ),
                title: const Text('Dark Mode', style: TextStyle(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                },
                trailing: ChangeThemeButtonWidget(),
                // Switch(
                //   onChanged: (val) {
                //     setState(() {
                //       isSwitched = val;
                //     });
                //   },
                //   value: isSwitched,
                //   activeColor: primaryClr,
                //   activeTrackColor: primaryClr.withOpacity(0.3),
                //   inactiveThumbColor: Colors.white,
                //   inactiveTrackColor: Colors.grey.withOpacity(0.3),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

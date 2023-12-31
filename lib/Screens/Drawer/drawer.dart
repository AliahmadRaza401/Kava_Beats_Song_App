import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kava_beats_app/services/auth_services.dart';
import 'package:kava_beats_app/services/shearedpref_service.dart';
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
    getUserLogin();
  }

  bool userLoggedIn = false;

  getUserLogin() async {
    var login = await ShearedprefService.getUserLoggedIn();
    print('login: ${login}');

    setState(() {
      userLoggedIn = login;
    });
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
          child: Column(
            // Important: Remove any padding from the ListView.
            children: [
              Container(
                width: width,
                child: DrawerHeader(
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
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : primaryClr,
                ),
                title: const Text('Home', style: TextStyle(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.feedback_rounded,
              //     color: primaryClr,
              //   ),
              //   title: const Text('Feedback', style: TextStyle(fontSize: 14)),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : primaryClr,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : primaryClr,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : primaryClr,
                ),
                title: const Text('Dark Mode', style: TextStyle(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                },
                trailing: ChangeThemeButtonWidget(),
              ),

              userLoggedIn == false
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(
                        Icons.logout_rounded,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : primaryClr,
                      ),
                      title:
                          const Text('Log Out', style: TextStyle(fontSize: 14)),
                      onTap: () {
                        AuthServices.signOut(context);
                      },
                    ),
              userLoggedIn == false
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(
                        Icons.person_off_outlined,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : primaryClr,
                      ),
                      title: const Text('Delete Account',
                          style: TextStyle(fontSize: 14)),
                      onTap: () {
                        showContactDeleteDialog(context);
                      },
                      trailing: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
              Spacer(),

              Container(
                  child: Text('Powered by M4 Limited',
                      style: TextStyle(fontSize: 14))),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showContactDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AccountDeleteDialog(
          onConfirm: () {
            // Handle delete logic
            // ...
            AuthServices.deleteUser(context); // Close the dialog
          },
          onCancel: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }
}

class AccountDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  AccountDeleteDialog({required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Delete Account'),
      content:
          Text('Are you sure you want to delete this account permanently?'),
      actions: [
        CupertinoDialogAction(
          onPressed: onCancel,
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onConfirm,
          child: Text(
            'OK',
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

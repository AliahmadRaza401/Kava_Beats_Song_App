import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:kava_beats_app/Constants/colors.dart';
import 'package:kava_beats_app/Screens/About/about_screen.dart';
import 'package:kava_beats_app/Screens/Home%20Screen/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Color mainColor = const Color(0xFF2631C1);
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        backgroundColor: Theme.of(context).cardColor,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        confineInSafeArea: true,
        decoration: const NavBarDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
        screens: const [
          HomeScreen(),
          AboutScreen(),
        ],
        items: _navBarsItems(),
        // navBarStyle: NavBarStyle.style1,
        // navBarStyle: NavBarStyle.style9,
        navBarStyle: NavBarStyle.style7,
        // navBarStyle: NavBarStyle.style10,
        // navBarStyle: NavBarStyle.style12,
        // navBarStyle: NavBarStyle.style13,
        // navBarStyle: NavBarStyle.style3,
        // navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.home,
          size: 20,
        ),
        title: ("Home"),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        activeColorPrimary: primaryClr,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: primaryClr),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.person_alt_circle_fill,
        size: 25,
      ),
      title: ("About"),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      activeColorPrimary: primaryClr,
      activeColorSecondary: Colors.white,
      inactiveColorPrimary: primaryClr,
    ),
  ];
}

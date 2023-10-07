import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:kava_beats_app/Screens/Book1/book1.dart';
import 'package:kava_beats_app/Screens/Book2/book2.dart';
import 'package:kava_beats_app/Screens/Drawer/drawer.dart';
import 'package:kava_beats_app/Screens/Login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: Theme.of(context).appBarTheme.elevation,
          backgroundColor: Theme.of(context).backgroundColor,
          iconTheme: Theme.of(context).appBarTheme.iconTheme,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(
                    CupertinoIcons.person_alt_circle,
                    color: Colors.white,
                    size: 33,
                  )),
            )
          ],
        ),
        // drawer: const NavigationDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   "My Library",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 30,
                //       fontWeight: FontWeight.bold),
                // ),
                // Container(
                //   height: 3,
                //   width: 140,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Book1Screen()));
                    },
                    child: songCard(
                        context: context,
                        bgClr: Theme.of(context).cardColor,
                        image: "assets/images/pic1.jpeg",
                        title: "HIVA\nKAKALA")),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Book2Screen()));
                    //  PersistentNavBarNavigator.pushNewScreen(
                    //     context,
                    //     screen: const Book2Screen(),
                    //     withNavBar: false, // OPTIONAL VALUE. True by default.
                    //     pageTransitionAnimation:
                    //         PageTransitionAnimation.cupertino,
                    //   );
                  },
                  child: songCard(
                      context: context,
                      bgClr: Theme.of(context).cardColor,
                      image: "assets/images/pic2.jpeg",
                      title: "HIVA\nFAKALOTU"),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget songCard(
    {required BuildContext context,
    required var bgClr,
    required var image,
    required var title}) {
  double width = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Stack(
      children: [
        Card(
          elevation: 25,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: 140,
            width: width,
            decoration: BoxDecoration(
              color: bgClr,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 140,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 40),
                  child:
                      Text(title, style: Theme.of(context).textTheme.headline2),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            right: 10,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 8, 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "view",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).iconTheme.color,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    ),
  );
}

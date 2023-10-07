import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kava_beats_app/Constants/colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        // appBar: AppBar(
        //   // elevation: 0,
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        //   title: const Text(
        //     "About",
        //     style: TextStyle(color: Colors.black),
        //   ),
        // ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Icon(
                CupertinoIcons.person_alt_circle_fill,
                size: 120,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "About",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 3,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: width * 0.85,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    "The book reading app is a modern tool that revolutionizes the way people enjoy literature. It offers an extensive collection of books across genres with a user-friendly interface. Readers can customize their reading experience and engage with a vibrant community of book lovers. Whether offline or online, the app provides easy access to captivating stories, making literature more accessible and enjoyable for everyone.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).toggleableActiveColor,
                        wordSpacing: 3,
                        letterSpacing: 1),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                "Author: Manule’oongo",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

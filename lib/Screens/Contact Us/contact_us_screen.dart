import 'package:flutter/material.dart';
// import 'package:flutter_launch/flutter_launch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kava_beats_app/Constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  bool err = false;
  String msgErr = '';
  // comment out

  // void whatsAppOpen() async {
  //   bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

  //   if (whatsapp) {
  //     await FlutterLaunch.launchWhatsapp(
  //         phone: "+923123456789",
  //         message: "Hello, I am coming from Kava Beats app.");
  //   } else {
  //     setState(() {
  //       err = false;
  //       msgErr = 'Something went wrong';
  //     });
  //   }
  // }

  String email = "edmond.fehoko@fehokoconsulting.org";
  launchEmail() async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }

  launchUrl(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: Theme.of(context).appBarTheme.elevation,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "FEHOKO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const Text(
              "CONSULTING LTD",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1.3),
            ),
            // const SizedBox(height: 10,),
            Image.asset(
              "assets/images/app_logo.png",
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.book,
                size: 28,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text(
                "Dr Edmond S. Fehoko | PhD, MA (Hons), BA (Criminology & Social Sciences), C.TT Director | Fehoko Consulting Ltd",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                launch('tel://+64 21 026 47008');
              },
              leading: FaIcon(
                FontAwesomeIcons.phone,
                size: 28,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text(
                "Mobile: +64 21 026 47008 Andersons Bay, Dunedin 9054 New Zealand | Aotearoa",
                style: TextStyle(fontSize: 14),
              ),
            ),

            ListTile(
              onTap: () {
                launchEmail();
              },
              leading: Icon(
                Icons.email,
                size: 30,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text(
                "Email: edmond.fehoko@fehokoconsulting.org",
                style: TextStyle(fontSize: 14),
              ),
            ),

            ListTile(
              onTap: () {
                launchUrl("http://www.fehokoconsulting.org");
              },
              leading: FaIcon(
                FontAwesomeIcons.globe,
                size: 28,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text(
                "Website: http://www.fehokoconsulting.org",
                style: TextStyle(fontSize: 14),
              ),
            ),

            ListTile(
              onTap: () {
                launchUrl("https://www.linkedin.com/in/edmond-fehoko/");
              },
              leading: FaIcon(
                FontAwesomeIcons.linkedin,
                size: 30,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text(
                "LinkedIn: https://www.linkedin.com/in/edmond-fehoko/",
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl("https://orcid.org/0000-0003-1809-5856");
              },
              leading: FaIcon(
                FontAwesomeIcons.globe,
                size: 28,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text(
                "ORCiD: https://orcid.org/0000-0003-1809-5856",
                style: TextStyle(fontSize: 14),
              ),
            ),
            // Card(
            //   elevation: 5,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(50),
            //   ),
            //   child: CircleAvatar(
            //     radius: 50,
            //     backgroundColor: primaryClr,
            //     child: Image.asset("assets/icons/support.png",height: 60,width: 60),),
            // ),
            // Card(
            //   margin: EdgeInsets.zero,
            //   elevation: 5,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(100)
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(15),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Theme.of(context).cardColor,
            //         borderRadius: BorderRadius.circular(100)
            //       ),
            //       child: Icon(Icons.support_agent_rounded,color: primaryClr,size: 80,)),
            //   )),
            // SizedBox(
            //   height: height * 0.1,
            // ),
            // Center(
            //   child: Card(
            //     elevation: 5,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            //       child: Container(
            //         width: width * 0.85,
            //         height: height * 0.22,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               "Have a question, feedback or complaint? Our team will be happy to support you as soon as possible.",
            //               textAlign: TextAlign.center,
            //               style: Theme.of(context).textTheme.bodyText2
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             const SizedBox(
            //                 child: Divider(
            //               color: Colors.grey,
            //             )),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceAround,
            //               children: [
            //                 //================ Email us ===============
            //                 GestureDetector(
            //                   onTap: () {
            //                     launchEmail();
            //                   },
            //                   child: Column(
            //                     children: [
            //                       Icon(
            //                         Icons.email,
            //                         color: primaryClr,
            //                         size: 30,
            //                       ),
            //                       const SizedBox(
            //                         height: 5,
            //                       ),
            //                       Text(
            //                         "Email us",
            //                         style: Theme.of(context).textTheme.bodyText2
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 //=================== Chat with us ===========
            //                 GestureDetector(
            //                   onTap: () {
            //                     whatsAppOpen();
            //                   },
            //                   child: Column(
            //                     children: [
            //                       Icon(
            //                         Icons.chat,
            //                         color: primaryClr,
            //                         size: 30,
            //                       ),
            //                       const SizedBox(
            //                         height: 5,
            //                       ),
            //                       Text(
            //                         "Chat with us",
            //                         style: Theme.of(context).textTheme.bodyText2
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 //================== Call us =================
            //                 GestureDetector(
            //                   onTap: () {
            //                     String number = "03123456789";
            //                     launch('tel://${number}');
            //                   },
            //                   child: Column(
            //                     children: [
            //                       Icon(
            //                         Icons.phone_in_talk_rounded,
            //                         color: primaryClr,
            //                         size: 30,
            //                       ),
            //                       const SizedBox(
            //                         height: 5,
            //                       ),
            //                      Text(
            //                         "Call us",
            //                         style: Theme.of(context).textTheme.bodyText2
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

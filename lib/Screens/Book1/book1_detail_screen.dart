import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kava_beats_app/Screens/Login/login_screen.dart';
import 'package:kava_beats_app/Widgets/app_toast.dart';
import 'package:kava_beats_app/Widgets/text_fields.dart';
import 'package:kava_beats_app/Widgets/widgets.dart';
import 'package:kava_beats_app/controller/auth_controller.dart';
import 'package:kava_beats_app/services/shearedpref_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kava_beats_app/Screens/Book1/book1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator_plus/translator_plus.dart';

class Book1DetailScreen extends StatefulWidget {
  Book1DetailScreen({super.key, this.book});
  Book1? book;
  @override
  State<Book1DetailScreen> createState() => _Book1DetailScreenState();
}

class _Book1DetailScreenState extends State<Book1DetailScreen> {
  final translator = GoogleTranslator();

  double textSize = 14;
  bool switchValue = false; // Variable to track the switch state

  void share() async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      widget.book!.content.toString(),
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  String content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Theme.of(context).appBarTheme.elevation,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          widget.book!.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              share();
            },
            icon: const Icon(
              Icons.share_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
      // backgroundColor: redClr,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.book!.title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.book!.number,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 17)),
              const SizedBox(
                height: 10,
              ),
              Text(
                "HIVA KAKALA",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    languageDropDown(),
                  ],
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: Column(
                  children: [
                    loading
                        ? Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: CircularProgressIndicator(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                            ),
                          )
                        : Text(
                            content == ""
                                ? widget.book!.content.toString()
                                : content,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: textSize)),
                    const SizedBox(
                      height: 70,
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(widget.book!.paragraph1.toString(),
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(fontSize: textSize)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 30),
            width: 200,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              onPressed: () {
                checkUserLoginAndDisplayFeedbaackDialog(
                    context, widget.book!.number);
              },
              child: Text("Write your feedback"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                onPressed: () {
                  textSize <= 10
                      ? const SizedBox()
                      : setState(() {
                          textSize -= 1;
                          print(textSize);
                        });
                },
                child: const Icon(
                  CupertinoIcons.minus,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FloatingActionButton(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                onPressed: () {
                  textSize >= 50
                      ? const SizedBox()
                      : setState(() {
                          textSize += 1;
                          print(textSize);
                        });
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _selectedLanguage = 'ton';

  Widget languageDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: _selectedLanguage,
        items: buildLanguageItems(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLanguage = newValue;
            });
            if (newValue == "ton") {
              setState(() {
                content = "";
              });
            } else {
              _translateText(newValue);
            }
          }
        },
        dropdownColor: Theme.of(context).appBarTheme.backgroundColor,
        style: TextStyle(color: Colors.white), // Text color
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Colors.white,
        ), // Dropdown icon
        iconSize: 24, // Size of the dropdown icon
        underline: Container(
          // Removes the default underline
          height: 0,
        ),
      ),
    );
  }

  bool loading = false;
  void _translateText(code) async {
    setState(() {
      loading = true;
    });
    try {
      translator
          .translate(widget.book!.content.toString(), to: code)
          .then((result) {
        print("Translated: ");

        setState(() {
          content = result.toString();
          loading = false;
        });
      });
    } catch (e) {
      print('e: ${e}');
      setState(() {
        content = "";
        loading = false;
      });
      var snackBar =
          SnackBar(content: Text('Oops! something worng try again later'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

List<DropdownMenuItem<String>> buildLanguageItems() {
  return [
    DropdownMenuItem<String>(
      value: 'ton',
      child: Text('Tonga'),
    ),
    DropdownMenuItem<String>(
      value: 'en',
      child: Text('English'),
    ),
    DropdownMenuItem<String>(
      value: 'es',
      child: Text('Spanish'),
    ),
    DropdownMenuItem<String>(
      value: 'pl',
      child: Text('Polish'),
    ),
    DropdownMenuItem<String>(
      value: 'pt',
      child: Text('Portuguese'),
    ),
    DropdownMenuItem<String>(
      value: 'it',
      child: Text('Italian'),
    ),
    DropdownMenuItem<String>(
      value: 'zh-cn',
      child: Text('Chinese'),
    ),
  ];
}

class FeedbackDialog extends StatefulWidget {
  final String docID;

  FeedbackDialog({required this.docID});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  FocusNode emailFocusNode = FocusNode();

  AuthController authController = Get.put(AuthController());

  String feedback = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  getEmail() async {
    var e = await ShearedprefService.getuseremail();
    setState(() {
      email = e;
      print('email: ${email}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Write Your Feedback'),
      content: Form(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFF072468),
                    )),
                child: Text('$email ')),
            SizedBox(
              height: 10,
            ),
            CupertinoTextField(
              placeholder: 'Enter your feedback here',
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              onChanged: (value) {
                feedback = value;
                // You can handle onChanged if needed
              },
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFF072468),
                  )),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFF072468),
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            if (feedback.isEmpty || feedback == "") {
              AppToast("Feedback is required", true);
            } else {
              print(feedback);
              FirebaseFirestore.instance.collection("feedback").doc().set(
                {"email": email, "refID": widget.docID, "feedback": feedback},
              );
              AppToast("Feedback Submitted Successfully", false);

              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Submit',
            style: TextStyle(
              color: Color(0xFF072468),
            ),
          ),
        ),
      ],
    );
  }
}

// Usage
void showFeedbackDialog(BuildContext context, docID) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FeedbackDialog(
        docID: docID,
      );
    },
  );
}

checkUserLoginAndDisplayFeedbaackDialog(context, docID) async {
  var login = await ShearedprefService.getUserLoggedIn();
  print('login: ${login}');

  if (login == true) {
    showFeedbackDialog(context, docID);
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NeedLoginDialog();
      },
    );
  }
}

class NeedLoginDialog extends StatelessWidget {
  NeedLoginDialog();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Account Required'),
      content: Text('you must need to login for submit your feedback'),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            AppRoutes.push(
              context,
              const LoginScreen(),
            );
          },
          child: Text(
            'Login',
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

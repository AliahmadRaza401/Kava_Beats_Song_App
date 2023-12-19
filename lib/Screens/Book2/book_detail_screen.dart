import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kava_beats_app/Screens/Book1/book1_detail_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kava_beats_app/Screens/Book2/book2.dart';
import 'package:translator_plus/translator_plus.dart';

class BookDetailScreen extends StatefulWidget {
  BookDetailScreen({super.key, this.book});
  Book? book;
  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  double textSize = 14;
  final translator = GoogleTranslator();
  String content = "";

  void share() async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      widget.book!.content.toString(),
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

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
                  style: Theme.of(context).textTheme.headline1),
              const SizedBox(
                height: 10,
              ),
              Text(
                "HIVA FAKALOTU",
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

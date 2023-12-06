import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kava_beats_app/Screens/Book1/book1.dart';
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
    );
  }

  String _selectedLanguage = 'es';

  Widget languageDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: _selectedLanguage,
        items: _buildLanguageItems(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLanguage = newValue;
            });
            _translateText(newValue);
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

  List<DropdownMenuItem<String>> _buildLanguageItems() {
    return [
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
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:kava_beats_app/Screens/Book1/book1.dart';
// import 'package:translator_plus/translator_plus.dart';

// class Book1DetailScreen extends StatefulWidget {
//   Book1DetailScreen({super.key, this.book});
//   Book1? book;
//   @override
//   State<Book1DetailScreen> createState() => _Book1DetailScreenState();
// }

// class _Book1DetailScreenState extends State<Book1DetailScreen> {
//   final translator = GoogleTranslator();

//   double textSize = 14;
//   bool switchValue = false; // Variable to track the switch state

//   void share() async {
//     final box = context.findRenderObject() as RenderBox?;

//     await Share.share(
//       widget.book!.content.toString(),
//       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
//     );
//   }

//   String content = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: Theme.of(context).appBarTheme.elevation,
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         title: Text(
//           widget.book!.title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               share();
//             },
//             icon: const Icon(
//               Icons.share_outlined,
//               color: Colors.white,
//               size: 22,
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 widget.book!.title,
//                 style: Theme.of(context).textTheme.bodyText2,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Divider(
//                 color: Colors.grey.withOpacity(0.3),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(widget.book!.number,
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline1!
//                       .copyWith(fontSize: 17)),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "HIVA KAKALA",
//                 style: Theme.of(context).textTheme.bodyText2,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Divider(
//                 color: Colors.grey.withOpacity(0.3),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Language",
//                       style: Theme.of(context).textTheme.bodyText2,
//                     ),
//                     languageDropDown(),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Divider(
//                 color: Colors.grey.withOpacity(0.3),
//               ),
//               const SizedBox(
//                 height: 0,
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
//                 child: Column(
//                   children: [
//                     Text(
//                         content == ""
//                             ? widget.book!.content.toString()
//                             : content,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: textSize)),
//                     const SizedBox(
//                       height: 70,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       // floatingActionButton: Row(
//       //   mainAxisAlignment: MainAxisAlignment.end,
//       //   children: [
//       //     FloatingActionButton(
//       //       backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       //       onPressed: () {
//       //         textSize <= 10
//       //             ? const SizedBox()
//       //             : setState(() {
//       //                 textSize -= 1;
//       //                 print(textSize);
//       //               });
//       //       },
//       //       child: const Icon(
//       //         CupertinoIcons.minus,
//       //         color: Colors.white,
//       //       ),
//       //     ),
//       //     const SizedBox(
//       //       width: 5,
//       //     ),
//       //     FloatingActionButton(
//       //       backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       //       onPressed: () {
//       //         textSize >= 50
//       //             ? const SizedBox()
//       //             : setState(() {
//       //                 textSize += 1;
//       //                 print(textSize);
//       //               });
//       //       },
//       //       child: const Icon(
//       //         Icons.add,
//       //         color: Colors.white,
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     );
//   }

//   String _translatedText = '';
//   String _selectedLanguage = 'en';

//   Widget languageDropDown() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.0),
//       decoration: BoxDecoration(
//         color: CupertinoColors.white,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             _selectedLanguage,
//             style: TextStyle(
//               fontSize: 16.0,
//               color: CupertinoColors.activeBlue,
//             ),
//           ),
//           CupertinoButton(
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               showLanguagePicker();
//             },
//             child: Icon(
//               CupertinoIcons.chevron_down,
//               size: 21.0,
//               color: CupertinoColors.activeBlue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   bool isSelectionCompleted = false;

//   void showLanguagePicker() {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           color: Colors.white,
//           height: 200.0,
//           child: CupertinoPicker(
//             itemExtent: 32.0,
//             onSelectedItemChanged: (int index) {
//               Navigator.pop(context);

//               String selectedLanguageCode = _buildLanguageItems()[index].value!;
//               setState(() {
//                 _selectedLanguage = selectedLanguageCode;
//               });
//               _translateText(selectedLanguageCode);
//             },
//             children:
//                 _buildLanguageItems().map((DropdownMenuItem<String> item) {
//               return Text(item.value!);
//             }).toList(),
//           ),
//         );
//       },
//     ).then((_) {
//       // Reset the flag when the modal is closed
//       setState(() {
//         isSelectionCompleted = false;
//       });
//     });
//   }

//   void _translateText(String code) async {
//     if (mounted) {
//       translator
//           .translate(widget.book!.content.toString(), to: code)
//           .then((result) {
//         print("Translated: ");

//         if (mounted) {
//           setState(() {
//             content = result.toString();
//           });
//         }
//       });
//     }
//   }

  // List<DropdownMenuItem<String>> _buildLanguageItems() {
  //   return [
  //     DropdownMenuItem<String>(
  //       value: 'en',
  //       child: Text('English'),
  //     ),
  //     DropdownMenuItem<String>(
  //       value: 'es',
  //       child: Text('Spanish'),
  //     ),
  //     DropdownMenuItem<String>(
  //       value: 'pl',
  //       child: Text('Polish'),
  //     ),
  //     DropdownMenuItem<String>(
  //       value: 'pt',
  //       child: Text('Portuguese'),
  //     ),
  //     DropdownMenuItem<String>(
  //       value: 'it',
  //       child: Text('Italian'),
  //     ),
  //     DropdownMenuItem<String>(
  //       value: 'zh-cn',
  //       child: Text('Chinese'),
  //     ),
  //   ];
  // }
// }

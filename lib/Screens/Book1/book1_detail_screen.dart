import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kava_beats_app/Screens/Book1/book1.dart';

class Book1DetailScreen extends StatefulWidget {
  Book1DetailScreen({super.key, this.book});
  Book1? book;
  @override
  State<Book1DetailScreen> createState() => _Book1DetailScreenState();
}

class _Book1DetailScreenState extends State<Book1DetailScreen> {
  double textSize = 18;

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
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: Column(
                  children: [
                    Text(widget.book!.content.toString(),
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
}

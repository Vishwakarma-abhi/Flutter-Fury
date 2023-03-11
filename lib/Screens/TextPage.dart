import 'package:dtexto/Screens/notes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

import 'package:dtexto/CustomWidget/customAppbar.dart';

class ViewText extends StatefulWidget {
  String text;
  ViewText({super.key, required this.text});

  @override
  State<ViewText> createState() => _ViewTextState();
}

class _ViewTextState extends State<ViewText> {
  late DatabaseReference dbRef;
  bool isSaved = false;
  @override
  void initState() {
    super.initState();
    //Here we are creating a table of name Students
    //with a reference of the database dbRef act as object for accessing database
    dbRef = FirebaseDatabase.instance.ref().child('Notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        //leading
        leading: Icon(
          Icons.account_circle,
          size: 45,
        ),
        //title
        title: Text('DTEXTO'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              'YOUR SCANNED TEXT',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: 50,
          ),
          // displaying the Scanned Text
          Container(
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),

          GestureDetector(
            onTap: (() {
              var str = widget.text;
              Map<String, String> notes = {"notes": str};
              setState(() {
                isSaved = !isSaved;
              });

              dbRef.push().set(notes);
            }),
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                  color: isSaved ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: Text(
                isSaved ? 'SAVED' : 'SAVE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: (() {
              Get.to(ScannedNotes());
              setState(() {});
            }),
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: Text(
                'VIEW NOTES',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}

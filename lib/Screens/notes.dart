import 'package:dtexto/CustomWidget/customAppbar.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class ScannedNotes extends StatefulWidget {
  const ScannedNotes({super.key});

  @override
  State<ScannedNotes> createState() => _ScannedNotesState();
}

class _ScannedNotesState extends State<ScannedNotes> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Notes');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Notes');
  bool isDone = false;

  Widget listItem({required Map student}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: 150,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 250, 194, 42),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: isDone,
              onChanged: (value) {
                setState(() {
                  isDone = value!;
                });
              }),
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
                notes['name'],
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
              GestureDetector(
                onTap: () {
                  //Delete Operation
                  reference.child(student['key']).remove();
                },
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar,
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              child: FirebaseAnimatedList(
                  query: dbRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map student = snapshot.value as Map;
                    student['key'] = snapshot.key;
                    return listItem(student: student);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

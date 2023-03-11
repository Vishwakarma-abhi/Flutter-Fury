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

  Widget listItem({required Map note}) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: 200,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Center(
              //   child: Text(
              //     'YOUR SCANNED TEXT',
              //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //   ),
              // ),

              // SizedBox(
              //   height: 50,
              // ),
              // displaying the Scanned Text
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Note',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              //Delete Operation
                              reference.child(note['key']).remove();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        note['notes'],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        //leading
        leading: Icon(
          Icons.notes,
          size: 45,
        ),
        //title
        title: Text('Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              child: FirebaseAnimatedList(
                  query: dbRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map note = snapshot.value as Map;
                    note['key'] = snapshot.key;
                    return listItem(note: note);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController mynote = TextEditingController();
  bool isSaved = false;
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
        title: Text('Write your note'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(),
            ),
            Container(
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
          ],
        ),
      ),
    );
  }
}

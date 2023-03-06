import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

import 'package:dtexto/CustomWidget/customAppbar.dart';

class ViewText extends StatelessWidget {
  final String text;
  const ViewText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar,
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
          Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

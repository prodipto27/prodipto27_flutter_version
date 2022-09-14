// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:Prodipto27/helper.dart';

class OtherResources extends StatelessWidget {
  const OtherResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          // A button with some text and icon
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.link),
                label: Text(
                  "Open Web Index".toUpperCase(),
                  //style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  open_link("https://web-index.prodipto27.workers.dev/");
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF6200EE)),
                  alignment: Alignment.topLeft,
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

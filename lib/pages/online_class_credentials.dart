// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:Prodipto27/helper.dart';

class OnlineClassCredentials extends StatelessWidget {
  const OnlineClassCredentials({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "অনলাইন ক্লাসের লিংক ও পাসওয়ার্ড দেখতে নিচের বাটনে ক্লিক করুন!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // A button with some text and icon
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     ElevatedButton.icon(
          //       icon: Icon(Icons.link),
          //       label: Text(
          //         "Open Webpage".toUpperCase(),
          //         //style: TextStyle(fontSize: 20, color: Colors.white),
          //       ),
          //       onPressed: () {
          //         open_link(
          //             "https://prodipto27.github.io/pages/credentials.html");
          //       },
          //       style: ButtonStyle(
          //         backgroundColor:
          //             MaterialStateProperty.all<Color>(Color(0xFF6200EE)),
          //         alignment: Alignment.topLeft,
          //         padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          //             EdgeInsets.all(16)),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

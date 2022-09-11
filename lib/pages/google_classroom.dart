// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:prodipto27_flutter_version/helper.dart';

class GoogleClassroom extends StatelessWidget {
  const GoogleClassroom({super.key});

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
                  "গোগনীয়তার খাতিরে Google Classroom এ জয়েন হওয়ার কোড এখানে না দিয়ে ফেসবুক পোস্টে দেওয়া হয়েছে। কোডটি নোট করে Google Classroom এ গিয়ে Join Class দিতে হবে।",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.link),
                label: Text(
                  "Open Facebook Post".toUpperCase(),
                  //style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  open_link(
                      "https://www.facebook.com/groups/ist.prodipto27/permalink/918676308846666/");
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.link),
                label: Text(
                  "Open Google Classroom".toUpperCase(),
                  //style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  open_link("https://classroom.google.com");
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

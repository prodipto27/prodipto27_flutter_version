// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:Prodipto27/helper.dart';

class HaveChromeBrowser extends StatelessWidget {
  const HaveChromeBrowser({super.key});

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
                  "আপনার ডিভাইসে ক্রোম ব্রাউজার ইন্সটল করা থাকলে এই অ্যাপের Web Version-টি ব্যবহার করে দেখতে পারেন!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
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
              Expanded(
                child: Text(
                  "সেটিও ন্যাটিভ অ্যাপের মতো কাজ করে, ব্রাউজার থেকে সরাসরি ইন্সটল করা যায় এবং ডিভাইসে তেমন কোন স্টোরেজ ব্যবহার করে না। ইন্সটল করতে নিচের বাটনে ক্লিক করে ক্রোম ব্রাউজার দিয়ে লিংকে গিয়ে ব্রাউজারে Add to Home Screen অপশনে ট্যাপ করুন।",
                  style: TextStyle(
                    fontSize: 17,
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
                  "Open Web Version".toUpperCase(),
                  //style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  launch_url("https://prodipto27.github.io/");
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

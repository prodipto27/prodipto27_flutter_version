// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:Prodipto27/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

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
                  "অ্যাপ সম্পর্কে কোনো জিজ্ঞাসা, অভিযোগ, মতামত অথবা পরামর্শ থাকলে নিচের বাটনে ক্লিক করুন!",
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
              ElevatedButton.icon(
                icon: Icon(Icons.link),
                label: Text(
                  "Feedback".toUpperCase(),
                  //style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  launchUrl(Uri.parse(
                      "https://prodipto27.github.io/pages/feedback.html"));
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

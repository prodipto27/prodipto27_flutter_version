import 'package:flutter/material.dart';

void main() {
  List<Map> drawer_properties = [
    {
      "title": Text(
        "Online Class Credentials",
        style: TextStyle(),
      ),
      "leading": Icon(Icons.vpn_key),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {
      "title": const Text('Class Routine'),
      "leading": Icon(Icons.event),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {
      "title": const Text('Syllabus'),
      "leading": Icon(Icons.book),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {
      "title": const Text('Books'),
      "leading": Icon(Icons.menu_book),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {
      "title": const Text('Other Resources'),
      "leading": Icon(Icons.download_for_offline),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {
      "title": const Text('Recorded Classes'),
      "leading": Icon(Icons.video_library),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {
      "title": const Text('Join Google Classroom'),
      "leading": Icon(Icons.school),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {
      "title": const Text('Settings'),
      "leading": Icon(Icons.settings),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {"title": "DIVIDER"},
    {
      "title": const Text('No Chrome Browser?'),
      "leading": Icon(Icons.help),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
    {
      "title": const Text('Feedback'),
      "leading": Icon(Icons.feedback),
      "selected": false,
      "selectedTileColor": Color(0xFFD9C2FB),
    },
  ];

  List<Map> temp_drawer_properties = [];

  for (int i = 0; i < drawer_properties.length; i++) {
    print(drawer_properties[i]);
    if (drawer_properties[i]["title"] != "DIVIDER") {
      temp_drawer_properties.add(drawer_properties[i]);
      print(drawer_properties[i]);
    }
  }

  print(temp_drawer_properties);
}

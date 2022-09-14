import 'package:flutter/material.dart';
import 'package:Prodipto27/helper.dart';
import 'package:Prodipto27/pages/class_routine.dart';

// List<Widget> Drawer_List() {
List<Widget> drawer_list = [
  DrawerHeader(
    // decoration: BoxDecoration(
    //   color: Colors.blue,
    // ),
    child: Column(
      children: [
        Image.asset(
          "assets/images/ist_logo.png",
          height: 90,
          width: 90,
          fit: BoxFit.cover,
        ),
        Text("Prodipto27"),
        Text("prodipto27.github.io"),
      ],
    ),
  ),
  // ListTile(
  //   // tileColor: Color(0xFFD9C2FB),
  //   selectedTileColor: Color(0xFFD9C2FB),
  //   title: Text("asdas"),
  //   leading: Icon(
  //     Icons.feedback,
  //     color: Color(0xFF6200EE),
  //   ),
  //   selected: true,
  //   onTap: () {
  //     // Update the state of the app
  //     // Then close the drawer
  //     Navigator.pop(context);
  //   },
  // ),
];

List<Map> drawer_list_click(List<Map> drawer_properties, int index) {
  for (int i = 0; i < drawer_properties.length; i++) {
    // print("action index $i");
    // print(drawer_properties[i]["title"].data);

    if (index == i) {
      drawer_properties[i]["selectedTileColor"] = Color(0xFFD9C2FB);
      drawer_properties[i]["leading"] = Icon(
        drawer_properties[i]["leading"].icon,
        color: Color(0xFF6200EE),
      );
      drawer_properties[i]["selected"] = true;
      drawer_properties[i]["title"] = Text(
        drawer_properties[i]["title"].data,
        style: TextStyle(
          color: Color(0xFF731DF0),
        ),
      );
    } else {
      drawer_properties[i]["selectedTileColor"] = null;
      try {
        drawer_properties[i]["title"] = Text(
          drawer_properties[i]["title"].data,
        );
        drawer_properties[i]["leading"] = Icon(
          drawer_properties[i]["leading"].icon,
        );
      } catch (e) {
        print("pass");
      }
      drawer_properties[i]["selected"] = false;
    }
  }

  return drawer_properties;
}

List<Map> drawer_properties = [
  {
    "title": Text(
      "Online Class Credentials",
      style: TextStyle(),
    ),
    "leading": Icon(
      Icons.vpn_key,
    ),
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
    "title": const Text('Have Chrome Browser?'),
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

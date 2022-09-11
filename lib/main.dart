// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prodipto27_flutter_version/drawer_list.dart';
import 'package:prodipto27_flutter_version/helper.dart';
import 'package:prodipto27_flutter_version/pages/class_routine.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prodipto27_flutter_version/pages/syllabus.dart';
import 'package:prodipto27_flutter_version/pages/books.dart';
import 'package:prodipto27_flutter_version/pages/other_resources.dart';
import 'package:prodipto27_flutter_version/pages/recorded_classes.dart';
import 'package:prodipto27_flutter_version/pages/google_classroom.dart';

void main() => runApp(const Prodipto27App());

class Prodipto27App extends StatefulWidget {
  const Prodipto27App({super.key});

  static const appTitle = 'Prodipto27';

  @override
  State<Prodipto27App> createState() => _Prodipto27AppState();
}

class _Prodipto27AppState extends State<Prodipto27App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: Prodipto27App.appTitle,
      home: HomePage(title: Prodipto27App.appTitle),
    );
  }
}

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

Widget main_container = Center(
  child: Text('Prodipto27 App'),
);

// {
//   "selectedTileColor": Color(0xFFD9C2FB),
//   "title": const Text(
//     'Feedback',
// style: TextStyle(
//   color: Color(0xFF731DF0),
// ),
//   ),
// "leading": Icon(
//   Icons.feedback,
//   color: Color(0xFF6200EE),
// ),
//   "selected": true,
// },

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

// ignore: non_constant_identifier_names

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF6200EE),
      ),
      body: main_container,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
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
            ...drawer_properties.mapIndexed((e, index) {
              // print(e);

              if (e["title"] == "DIVIDER") {
                return const Divider(
                  height: 20,
                );
              } else {
                return ListTile(
                  title: e["title"],
                  leading: e["leading"],
                  selected: e["selected"],
                  selectedTileColor: e["selectedTileColor"],
                  onTap: () {
                    // Update the state of the app
                    setState(() {
                      drawer_properties =
                          drawer_list_click(drawer_properties, index);

                      try {
                        print(e["title"]);
                        if (e["title"].data.contains("Class Routine")) {
                          Widget spinner = Center(
                            child: SpinKitRotatingCircle(
                              color: Colors.blue,
                              size: 50.0,
                            ),
                          );
                          main_container = spinner;
                          main_container = FutureBuilder(
                              future: get_routine_html(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Center(
                                        child: Html(
                                          data: snapshot.data.toString(),
                                          shrinkWrap: true,
                                        ),
                                      ),
                                    ),
                                  ]);
                                } else {
                                  return spinner;
                                }
                              });

                          //   print("widget placed");
                          // });
                        } else if (e["title"].data.contains("Syllabus")) {
                          main_container = Syllabus();
                        } else if (e["title"].data.contains("Books")) {
                          main_container = Books();
                        } else if (e["title"]
                            .data
                            .contains("Other Resources")) {
                          main_container = OtherResources();
                        } else if (e["title"]
                            .data
                            .contains("Recorded Classes")) {
                          main_container = RecordedClasses();
                        } else if (e["title"]
                            .data
                            .contains("Google Classroom")) {
                          main_container = GoogleClassroom();
                        }
                      } catch (e) {
                        print("pass");
                        print(e);
                      }
                    });
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}

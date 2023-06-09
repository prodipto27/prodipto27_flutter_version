// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'widget_background_task.dart'; // Import the widget background task file
import 'package:localstorage/localstorage.dart';
import 'package:Prodipto27/helper.dart';
import 'package:Prodipto27/drawer_list.dart';
import 'package:Prodipto27/pages/class_routine.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Prodipto27/pages/feedback.dart';
import 'package:Prodipto27/pages/have_chrome_browser.dart';
import 'package:Prodipto27/pages/syllabus.dart';
import 'package:Prodipto27/pages/books.dart';
import 'package:Prodipto27/pages/other_resources.dart';
import 'package:Prodipto27/pages/recorded_classes.dart';
import 'package:Prodipto27/pages/google_classroom.dart';
import 'package:Prodipto27/pages/online_class_credentials.dart';
import 'package:Prodipto27/pages/settings.dart';
import 'package:Prodipto27/pages/updater.dart';
import 'package:Prodipto27/pages/have_chrome_browser.dart';
import 'package:Prodipto27/pages/feedback.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:home_widget/home_widget.dart';
import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

Future<void> backgroundCallback(Uri? uri) async {
  if (uri?.host == 'updatecounter') {
    int counter = 0;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      counter = value!;
      counter++;
    });
    await HomeWidget.saveWidgetData<int>('_counter', counter);
    await HomeWidget.updateWidget(
        //this must the class name used in .Kt
        name: 'HomeScreenWidgetProvider',
        iOSName: 'HomeScreenWidgetProvider');
  }
}

String get_day_and_date() {
  // Get current day and date
  final now = DateTime.now();
  final dayOfWeek = DateFormat.EEEE().format(now);
  final currentDate = DateFormat('dd MMMM').format(now);

  return "$dayOfWeek, $currentDate";
}


void main() {
    WidgetsFlutterBinding.ensureInitialized();
    Workmanager workmanager = Workmanager();
    workmanager.initialize(callbackDispatcher, isInDebugMode: true);
    workmanager.registerPeriodicTask(
      "1",
      "widget_background_task",
      frequency: Duration(minutes: 5),
      initialDelay: Duration(seconds: 10),
  );
  runApp(const Prodipto27App());
}

class Prodipto27App extends StatelessWidget {
  const Prodipto27App({super.key});

  static const appTitle = 'Prodipto27';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset(
          "assets/images/ist_logo.png",
          height: 200,
          width: 200,
          fit: BoxFit.scaleDown,
        ),
        nextScreen: HomePage(title: appTitle),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        backgroundColor: Color.fromARGB(255, 246, 243, 227),
      ),
    );
  }
}

// String html_data = "";

Widget spinner = Center(
  // child: SpinKitPumpingHeart(
  // color: Colors.blue,
  // size: 50.0,
  // ),
  child: CircularProgressIndicator(
    color: Colors.blue,
    //size: 50.0,
  ),
);

Widget main_container = spinner;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

String default_page = "Class Routine";
// ignore: non_constant_identifier_names

class _HomePageState extends State<HomePage> {
  String day_and_date = get_day_and_date();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeWidget.widgetClicked.listen((Uri? uri) => updateAppWidget());
    updateAppWidget(); // This will load data from widget every time app is opened

    final LocalStorage storage = new LocalStorage('localdata.json');
    storage.ready.then((value) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
            default_page = storage.getItem('default_page') ?? "Class Routine";
            // if (default_page.contains("Online Class Credentials")) {
            //   // open_link("https://prodipto27.github.io/pages/credentials.html");
            //   main_container = OnlineClassCredentials();
            // } else
            if (default_page.contains("Class Routine")) {
              main_container = spinner;
              Widget temp = ClassRoutine();
              main_container = temp;
            } else if (default_page.contains("Syllabus")) {
              main_container = Syllabus();
            } else if (default_page.contains("Books")) {
              main_container = Books();
            } else if (default_page.contains("Other Resources")) {
              main_container = OtherResources();
            } else if (default_page.contains("Recorded Classes")) {
              main_container = RecordedClasses();
            } else if (default_page.contains("Google Classroom")) {
              main_container = GoogleClassroom();
            } else if (default_page.contains("Settings")) {
              main_container = Settings();
            } else if (default_page.contains("Have Chrome Browser")) {
              main_container = HaveChromeBrowser();
            } else if (default_page.contains("Feedback")) {
              main_container = FeedbackPage();
            }
          }));
    });
  }

/* For HomeScreen Widget */
  
  // Future<void> updateAppWidget() async {
  //   await HomeWidget.saveWidgetData<String>('day_and_date', day_and_date);
  //   await HomeWidget.updateWidget(
  //       name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  // }

/* For HomeScreen Widget */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF6200EE),
        actions: [
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Share This App'),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.delete_sweep,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Clear Cache Data'),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.psychology,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('হুদাই!'),
                  ],
                ),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              if (Platform.isAndroid || Platform.isIOS) {
                Share.share(
                    'Check Out Prodipto27 App https://prodipto27.github.io/?page=download-app-apk.html');
              } else {
                launch_url(
                    'https://prodipto27.github.io/?page=download-app-apk.html');
              }
            } else if (value == 1) {
              DefaultCacheManager().emptyCache().then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Cache Cleared"),
                ));
              });
            } else if (value == 2) {
              play_bodda_sound(context);
            }
          }),
        ],
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
                  Text("Prodipto27",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "prodipto27.github.io",
                    style: TextStyle(
                      color: Color(0xFF6C6C6C),
                    ),
                  ),
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

                      // try {
                      print(e["title"]);

                      if (e["title"]
                          .data
                          .contains("Online Class Credentials")) {
                        open_link(
                            "https://prodipto27.github.io/pages/credentials.html");
                        main_container = OnlineClassCredentials();
                      } else if (e["title"].data.contains("Class Routine")) {
                        main_container = spinner;
                        // main_container = html_widget(get_routine_html());
                        main_container = ClassRoutine();
                      } else if (e["title"].data.contains("Syllabus")) {
                        main_container = Syllabus();
                      } else if (e["title"].data.contains("Books")) {
                        main_container = Books();
                      } else if (e["title"].data.contains("Other Resources")) {
                        main_container = OtherResources();
                      } else if (e["title"].data.contains("Recorded Classes")) {
                        main_container = RecordedClasses();
                      } else if (e["title"].data.contains("Google Classroom")) {
                        main_container = GoogleClassroom();
                      } else if (e["title"].data.contains("Settings")) {
                        main_container = Settings();
                      } else if (e["title"]
                          .data
                          .contains("Check For Updates")) {
                        main_container = Updater();
                      } else if (e["title"]
                          .data
                          .contains("Have Chrome Browser")) {
                        main_container = HaveChromeBrowser();
                      } else if (e["title"].data.contains("Feedback")) {
                        main_container = FeedbackPage();
                      }
                    });

                    // Then close the drawer
                    Navigator.pop(context);
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

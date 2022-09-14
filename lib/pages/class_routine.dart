// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names

import 'package:Prodipto27/helper.dart';
import 'package:Prodipto27/main.dart';
import 'package:requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_html/flutter_html.dart';

String routine_html_url = "https://orange-cake-0407.prodipto27.workers.dev/";

Future<String> routine_html_request() async {
  String body = '';
  try {
    var r = await Requests.get(routine_html_url);
    // r.raiseForStatus();
    body = r.content();
  } catch (e) {
    body = "Error: $e";
  }

  return body;
}

Future<String> get_routine_html(BuildContext context) async {
  final LocalStorage storage = new LocalStorage('localdata.json');
  final ready_storage = await storage.ready;
  String html_data = storage.getItem('routine_html') != null
      ? storage.getItem('routine_html')
      : await routine_html_request();

  if (html_data != null) {
    print("Loaded from local storage");
    showToast(context, "Loaded Saved Routine");
    return html_data;
  } else {
    final body = routine_html_request();
    print("Loaded from server");
    return body;
  }
}

Future<String> routine_html_request_extra(BuildContext context) async {
  String body = await routine_html_request();

  if (!body.contains("Error:")) {
    final LocalStorage storage = new LocalStorage('localdata.json');
    final ready_storage = await storage.ready;
    storage.setItem('routine_html', body);
    print("Saved to local storage");
    print(storage.getItem('routine_html'));
    showToast(context, "Routine updated");
  }

  return body;
}

Future<String> future_fn(Future<String> fn) async {
  return fn;
}

class ClassRoutine extends StatefulWidget {
  const ClassRoutine({super.key});

  @override
  State<ClassRoutine> createState() => _ClassRoutineState();
}

class _ClassRoutineState extends State<ClassRoutine> {
  String html_data = "";
  Widget html_widget({final string_html_data: null}) {
    if (string_html_data != null) {
      return Html(
        data: string_html_data,
        shrinkWrap: true,
      );
    }
    return Html(
      data: html_data,
      shrinkWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get_routine_html(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                routine_html_request_extra(context).then((value) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => setState(() {
                            html_data = value;
                          }));
                });
              },
              backgroundColor: Color(0xFF6200EE),
              child: const Icon(Icons.refresh),
            ),
            body: ListView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: html_widget(string_html_data: snapshot.data),
                  ),
                ),
              ],
            ),
          );
        } else {
          return spinner;
        }
      },
    );
  }
}

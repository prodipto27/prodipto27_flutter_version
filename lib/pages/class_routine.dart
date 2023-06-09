// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:Prodipto27/helper.dart';
import 'package:Prodipto27/main.dart';
import 'package:intl/intl.dart';
import 'package:requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;
import 'package:home_widget/home_widget.dart';

String routine_html_url = "https://orange-cake-0407.prodipto27.workers.dev/";

Future<String> routine_html_request() async {
  String body = '';
  try {
    var r = await Requests.get(routine_html_url);
    // r.raiseForStatus();
    body = r.content().replaceAll("</body>",
        "<script>document.body.style.zoom=1.4;this.blur();</script></body>");
  } catch (e) {
    body = "Error: $e";
  }

  return body;
}

Future<String> get_routine_html() async {
  final LocalStorage storage = new LocalStorage('localdata.json');
  final ready_storage = await storage.ready;
  String html_data =
      storage.getItem('routine_html') ?? await routine_html_request();

  if (html_data != null && html_data != "") {
    // showToast(context, "Loaded Saved Routine");
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
    final LocalStorage storage = LocalStorage('localdata.json');
    final ready_storage = await storage.ready;
    storage.setItem('routine_html', body);
    print("Saved to local storage");
    print(storage.getItem('routine_html'));
    showToast(context, "Routine updated");
  }

  return body;
}

// -----------------------------------------------------------------------------
Future<List<String>> get_class_today_string() async {
  String htmlContent = await get_routine_html();

  // an array of days of the week
  List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  List<Map<String, String>> jsonData = parseTableToJSON(htmlContent);
  String jsonString = jsonData.toString();

  var classes_today = "";
  var current_class = "No Classes Now!";

  for (var entry in jsonData) {
    String currentDay = weekdays[DateTime.now().weekday - 1];

    if (entry['Day']?.trim() == currentDay) {
      for (var key in entry.keys) {
        key = key.trim();
        var value = entry[key]?.trim();
        classes_today += "$key -> $value\n";

        try {
          var time_lower_range = key.split("-")[0];
          
          if (!time_lower_range.contains(":")) {
            time_lower_range =
                time_lower_range.replaceAll("  ", " ").replaceAll(" ", ":00 ");
          }
          // add current date infront of time
          time_lower_range =
              "${DateFormat('d.M.y').format(DateTime.now())} $time_lower_range"
                  .toUpperCase();
          var time_lower_range_dt =
              DateFormat('d.M.y hh:mm a').parse(time_lower_range);

          var time_upper_range = key.split("-")[1];
          if (!time_upper_range.contains(":")) {
            time_upper_range =
                time_upper_range.replaceAll("  ", " ").replaceAll(" ", ":00 ");
          }
  
          time_upper_range =
              "${DateFormat('d.M.y').format(DateTime.now())} $time_upper_range"
                  .toUpperCase();
          var time_upper_range_dt =
              DateFormat('d.M.y hh:mm a').parse(time_upper_range);

          if ((time_lower_range_dt.isAtSameMomentAs(DateTime.now()) ||
                  time_lower_range_dt.isBefore(DateTime.now())) &&
              (time_upper_range_dt.isAtSameMomentAs(DateTime.now()) ||
                  time_upper_range_dt.isAfter(DateTime.now()))) {
            current_class = "Current Class: " + entry[key]!;
            break;
          }
        } catch (e) {
          print(e);
          // showToast(context, e.toString());
        }
      }
    }
  }
  return [classes_today, current_class];
}

void updateAppWidget() async {
    await HomeWidget.saveWidgetData<String>('day_and_date', get_day_and_date());

    List classes = await get_class_today_string();
    await HomeWidget.saveWidgetData<String>('classes_and_time', classes[0]);
    await HomeWidget.saveWidgetData<String>('current_class', classes[1]);
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

List<Map<String, String>> parseTableToJSON(String htmlTable) {
  List<Map<String, String>> tableData = [];

  htmlDom.Document document = htmlParser.parse(htmlTable);
  htmlDom.Element? table = document.querySelector('table');
  List<htmlDom.Element>? rows = table?.querySelectorAll('tr');

  if (table != null && rows != null) {
    // Get the header row
    List<htmlDom.Element> headerColumns = rows[0].querySelectorAll('td');
    List<String> headers =
        headerColumns.map((column) => column.text.trim()).toList();

    // Process each row
    for (int i = 1; i < rows.length; i++) {
      List<htmlDom.Element> columns = rows[i].querySelectorAll('td');
      Map<String, String> rowData = {};

      for (int j = 0; j < columns.length; j++) {
        String columnName = headers[j];
        String columnValue = columns[j].text.trim();

        rowData[columnName] = columnValue;
      }

      tableData.add(rowData);
    }
  }

  return tableData;
}

// -----------------------------------------------------------------------------

Future<String> future_fn(Future<String> fn) async {
  return fn;
}

class ClassRoutine extends StatefulWidget {
  const ClassRoutine({super.key});

  @override
  State<ClassRoutine> createState() => _ClassRoutineState();
}

class _ClassRoutineState extends State<ClassRoutine> {
  late WebViewController webViewController;
  String html_data = "";

  @override
  void initState() {
    super.initState();
    get_routine_html().then((value) {
      setState(() {
        html_data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          routine_html_request_extra(context).then((value) {
            // set state and reload
            setState(() {
              html_data = value;
            });
            // Reload the WebView with the updated HTML content
            webViewController.loadUrl(
              Uri.dataFromString(
                html_data,
                mimeType: 'text/html',
                encoding: Encoding.getByName('utf-8'),
              ).toString(),
            );
          });
          updateAppWidget();
        },
        backgroundColor: Color(0xFF6200EE),
        child: const Icon(Icons.refresh),
      ),
      body: WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          webViewController = controller;
          if (html_data.isNotEmpty) {
            webViewController.loadUrl(
              Uri.dataFromString(
                html_data,
                mimeType: 'text/html',
                encoding: Encoding.getByName('utf-8'),
              ).toString(),
            );
          }
        },
      ),
    );
  }
}

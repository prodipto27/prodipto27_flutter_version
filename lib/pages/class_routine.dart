// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:Prodipto27/helper.dart';
import 'package:Prodipto27/main.dart';
import 'package:requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

String routine_html_url = "https://orange-cake-0407.prodipto27.workers.dev/";

Future<String> routine_html_request() async {
  String body = '';
  try {
    var r = await Requests.get(routine_html_url);
    // r.raiseForStatus();
    body = r.content().replaceAll("</body>", "<script>document.body.style.zoom=1.4;this.blur();</script></body>");
  } catch (e) {
    body = "Error: $e";
  }

  return body;
}

Future<String> get_routine_html(BuildContext context) async {
  final LocalStorage storage = new LocalStorage('localdata.json');
  final ready_storage = await storage.ready;
  String html_data = storage.getItem('routine_html') ?? await routine_html_request();

  if (html_data != null) {
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
    final LocalStorage storage = LocalStorage('localdata.json');
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
  late WebViewController webViewController;
  String html_data = "";

  @override
  void initState() {
    super.initState();
    get_routine_html(context).then((value) {
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

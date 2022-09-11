import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:requests/requests.dart';
import 'package:flutter/material.dart';

String routine_html_url = "https://orange-cake-0407.prodipto27.workers.dev/";

Future<String> get_routine_html() async {
  var r = await Requests.get(routine_html_url);
  r.raiseForStatus();
  String body = r.content();
  // print(body);
  // dom.Document document = htmlparser.parse(body);

  // return SafeArea(
  //   child: ListView(children: [
  //     SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Center(
  //         child: Html(
  //           data: body,
  //           shrinkWrap: true,
  //         ),
  //       ),
  //     ),
  //   ]),
  // );
  return body;
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'dart:io' show Platform;
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
// import 'dart:js' as js;

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

Future<void> launch_url(String url, {bool useDom = false}) async {
  Uri _url = Uri.parse(url);
  print(canLaunchUrl);
  try {
    if (useDom == false) {
      await launchUrl(
        _url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      await launchUrl(
        _url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          enableDomStorage: true,
          enableJavaScript: true,
        ),
      );
    }
  } catch (e) {
    try {
      await launchUrl(_url);
    } catch (e, stacktrace) {
      print('Exception: ' + e.toString());
      print('Stacktrace: ' + stacktrace.toString());

      // try {

      //   js.context
      //       .callMethod('open', ['https://stackoverflow.com/questions/ask']);
      // } catch (e, stacktrace) {
      //   print('Exception: ' + e.toString());
      //   print('Stacktrace: ' + stacktrace.toString());
      // }
    }
  }
}

void open_link(String url) {
  try {
    print("${Platform.isAndroid} ${Platform.isIOS}");
    if (Platform.isAndroid || Platform.isIOS) {
      FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: const CustomTabsOptions(
          colorScheme: CustomTabsColorScheme.dark,
          // toolbarColor: Colors.deepPurple,
          // secondaryToolbarColor: Colors.green,
          // navigationBarColor: Colors.amber,
          shareState: CustomTabsShareState.on,
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: true,
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          preferredBarTintColor: Colors.green,
          preferredControlTintColor: Colors.amber,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        ),
      );
    } else {
      launch_url(url, useDom: true);
    }
  } catch (e, stacktrace) {
    // print('Exception: ' + e.toString());
    // print('Stacktrace: ' + stacktrace.toString());
    // try {
    //   js.context.callMethod('open', [url]);
    // } catch (e, stacktrace) {
    //   print('Exception: ' + e.toString());
    //   print('Stacktrace: ' + stacktrace.toString());
    // }
  }
}

void showToast(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(text),
      // action: SnackBarAction(
      //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

void play_bodda_sound(BuildContext context) async {
  var assetsFile =
      await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(assetsFile);
  List<String> listMp3 =
      manifestMap.keys.where((String key) => key.contains('.mp3')).toList();

  var rng = Random();
  int index = rng.nextInt(listMp3.length);
  String filename = listMp3[index].split('/').last;

  AudioPlayer audioPlayer = AudioPlayer();
  audioPlayer.play(AssetSource("sounds/" + filename));
}

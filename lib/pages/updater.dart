import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_checker/store_checker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Updater extends StatefulWidget {
  const Updater({super.key});

  @override
  State<Updater> createState() => _UpdaterState();
}

Widget spinner = const Center(
  // child: SpinKitPumpingHeart(
  // color: Colors.blue,
  // size: 50.0,
  // ),
  child: CircularProgressIndicator(
    color: Colors.blue,
    //size: 50.0,
  ),
);

const GITHUB_RELEASES_URL =
    "https://api.github.com/repos/prodipto27/prodipto27_flutter_version/releases/latest";

Future<List> new_release_check() async {
  List body = [];
  try {
    var r = await Requests.get(GITHUB_RELEASES_URL);
    // r.raiseForStatus();
    body = r.json()['assets'] as List;
    // print(body);
  } catch (e) {
    body = [
      {"error": e.toString()}
    ];
  }

  return body;
}

Widget release_list(latest_relase_json) {
  // print("release_list");
  // print(latest_relase_json);

  // check latest_relase_json type
  if (latest_relase_json is Widget) {
    return spinner;
  }

  if (latest_relase_json[0]['name'] != null) {
    return ListView(children: [
      for (var i = 0; i < latest_relase_json.length; i++)
        ListTile(
          title: Text(latest_relase_json[i]['name']),
          subtitle: Text(latest_relase_json[i]['browser_download_url']),
        ),
    ]);
  } else {
    return const Center(
      // add error message in a Text widget
      child: Text("Unable to fetch latest release"),
    );
  }
}

class _UpdaterState extends State<Updater> {
  List latest_relase_json = [];

  @override
  Widget build(BuildContext context) {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      String currentInstalledVersion = "v" + version + "+" + buildNumber;
    });

    // StoreChecker.getSource.then((value) {
    //   print("object");
    //   print(value);
    // });

    if (kIsWeb) {
      return const Scaffold(
        body: Center(
          child: Text("Web version doesn't support update"),
        ),
      );
    }

    return FutureBuilder(
      future: new_release_check(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          latest_relase_json = snapshot.data!;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                release_list(spinner);
                new_release_check().then((value) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => setState(() {
                            latest_relase_json = value;
                          }));
                });
              },
              backgroundColor: Color(0xFF6200EE),
              child: const Icon(Icons.refresh),
            ),
            body: release_list(latest_relase_json),
          );
        } else {
          return spinner;
        }
      },
    );
  }
}

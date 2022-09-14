// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:Prodipto27/drawer_list.dart';
import 'package:localstorage/localstorage.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String dropdown_value = drawer_properties[0]["title"].data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      () async {
        final LocalStorage storage = new LocalStorage('localdata.json');
        final ready_storage = await storage.ready;
        if (storage.getItem('default_page') != null) {
          setState(() {
            dropdown_value = storage.getItem('default_page');
          });
        }
      }();
    });
  }

  void update_default_page(String dropdown_value) async {
    final LocalStorage storage = new LocalStorage('localdata.json');
    final ready_storage = await storage.ready;
    storage.setItem('default_page', dropdown_value);
  }

  @override
  Widget build(BuildContext context) {
    List<Map> temp_drawer_properties = [];

    for (int i = 0; i < drawer_properties.length; i++) {
      print(drawer_properties[i]);
      if (drawer_properties[i]["title"] != "DIVIDER") {
        temp_drawer_properties.add(drawer_properties[i]);
        print(drawer_properties[i]);
      }
    }
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            "Select Default Page:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: DropdownButton(
                isExpanded: true,
                value: dropdown_value,
                items: temp_drawer_properties.map((element) {
                  print(element["title"]);
                  return DropdownMenuItem(
                    child: Text(element["title"].data),
                    value: element["title"].data,
                  );
                }).toList(),
                onChanged: (new_value) {
                  setState(() {
                    print(new_value);
                    dropdown_value = new_value.toString();
                    update_default_page(dropdown_value);
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

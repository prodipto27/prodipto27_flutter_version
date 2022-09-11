import 'package:flutter/material.dart';
import 'package:prodipto27_flutter_version/helper.dart';

class Syllabus extends StatelessWidget {
  const Syllabus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('1st Year'),
          leading: const Icon(Icons.looks_one),
          onTap: () {
            open_link(
                "https://drive.google.com/file/d/16md80i3eFpU0WKKH_OgKadgjJPhzlHgg/view?usp=sharing");
          },
        ),
        ListTile(
          title: const Text('2nd Year'),
          leading: const Icon(Icons.looks_two),
          onTap: () {
            open_link(
                "https://drive.google.com/file/d/1MT9e2osiCgEEBl2AHhjCZUSGoGZ3odcc/view?usp=sharing");
          },
        ),
        ListTile(
          title: const Text('3rd Year'),
          leading: const Icon(Icons.looks_3),
          onTap: () {
            open_link(
                "https://drive.google.com/file/d/18hETzuh71VAM83RwxVzLql0bm07UvIvN/view");
          },
        ),
        ListTile(
          title: const Text('4th Year'),
          leading: const Icon(Icons.looks_4),
          onTap: () {
            open_link(
                "https://drive.google.com/file/d/1jRaIiv_CuZ7wnNEO5ojo4PPep0xfdATm/view?usp=sharing");
          },
        ),
        ListTile(
          title: const Text('Full Syllabus in zip (Download Only)'),
          leading: const Icon(Icons.inventory_2),
          onTap: () {
            open_link(
                "https://drive.google.com/file/d/1ZUNgMX2UxVAMgnphpSWIGhFxcKDrakEc/view");
          },
        ),
        FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.navigation),
        ),
      ],
    );
  }
}

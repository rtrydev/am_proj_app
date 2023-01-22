import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game_map.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}): super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    var drawer = Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('test'),),
      drawer: drawer,
      body: const MapSample(),
    );
  }
}
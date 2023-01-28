import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dependency_injection.dart';
import '../models/user_data.dart';
import '../services/i_user_service.dart';
import 'game_map.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}): super(key: key);


  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  UserData? currentUser;
  final IUserService userService = getIt<IUserService>();

  @override
  Widget build(BuildContext context) {
    userService.getUser()
      .then((user) {
        setState(() {
          currentUser = user;
        });
      }
    );

    var drawer = Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(currentUser?.username ?? '', style: const TextStyle(color: Colors.white, fontSize: 24),),
          ),
          ListTile(
            title: const Text('Odwiedzone punkty'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Odpowiedzi'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('AM Project Game'),),
      drawer: drawer,
      body: const GameMap(),
    );
  }
}
import 'package:am_proj_app/widgets/visited_waypoints.dart';
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
  late Future<UserData> currentUser;
  final IUserService userService = getIt<IUserService>();

  Widget currentBody = const GameMap();

  @override
  void initState() {
    super.initState();
    currentUser = userService.getUser();
  }

  @override
  Widget build(BuildContext context) {


    var drawer = Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: FutureBuilder<UserData>(future: currentUser, builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
              if(snapshot.hasData) {
                return Text(snapshot.data?.username ?? '', style: const TextStyle(color: Colors.white, fontSize: 24));
              } else {
                return const Text("");
              }
            },),
          ),
          ListTile(
            title: const Text('Mapa'),
            onTap: () {
              setState(() {
                currentBody = const GameMap();
              });
            },
          ),
          ListTile(
            title: const Text('Odwiedzone punkty'),
            onTap: () {
              setState(() {
                currentBody = const VisitedWaypoints();
              });
            },
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('AM Project Game'),),
      drawer: drawer,
      body: currentBody,
    );
  }
}
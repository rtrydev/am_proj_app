import 'package:am_proj_app/dependency_injection.dart';
import 'package:am_proj_app/routes/login.dart';
import 'package:am_proj_app/routes/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AM Project',
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login()
      },
    );
  }
}

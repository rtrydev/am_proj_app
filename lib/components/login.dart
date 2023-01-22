import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}): super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var loginFormBody = Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
        child: Column(
          children: const [
            Text('test', style: TextStyle(fontSize: 16, color: Colors.white, fontStyle: FontStyle.normal))
          ],
        )
      )
    );

    return loginFormBody;
  }
}
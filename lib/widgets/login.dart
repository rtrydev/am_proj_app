import 'package:am_proj_app/dependency_injection.dart';
import 'package:am_proj_app/routes/main_screen.dart';
import 'package:am_proj_app/services/i_user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}): super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final IUserService userService = getIt<IUserService>();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool isLoggingIn = false;

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

  Future<void> login() async {
    setState(() {
      isLoggingIn = true;
    });

    final loginResult = await userService.signIn(
        username: usernameTextController.text,
        password: passwordTextController.text
    );

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MainScreen())
    );

    setState(() {
      isLoggingIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginFormBody = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('AM Project', style: TextStyle(fontSize: 28)),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.only(left: 80.0, right: 80.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: const InputDecoration(
                  hintText: 'username'
              ),
              controller: usernameTextController,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(left: 80.0, right: 80.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: const InputDecoration(
                  hintText: 'password'
              ),
              obscureText: true,
              controller: passwordTextController,
            ),
          ),
          const SizedBox(height: 32),
          !isLoggingIn
              ? ElevatedButton(
                  onPressed: login,
                  child: const Text('Sign in'))
              : const CircularProgressIndicator()
        ],
      )
    );

    return Scaffold(
      body: loginFormBody,
    );
  }
}
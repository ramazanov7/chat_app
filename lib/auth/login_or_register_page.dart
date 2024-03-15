import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:flutter/material.dart';

class LoginOfRegisterPage extends StatefulWidget {
  const LoginOfRegisterPage({super.key});

  @override
  State<LoginOfRegisterPage> createState() => _LoginOfRegisterPageState();
}

class _LoginOfRegisterPageState extends State<LoginOfRegisterPage> {

  // initially, show login page
  bool showLoginPage = true;

  // toggle between login and register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
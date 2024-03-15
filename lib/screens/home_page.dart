// ignore_for_file: prefer_const_constructors

import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      drawer: MyDrawer(),
    );
  }
}
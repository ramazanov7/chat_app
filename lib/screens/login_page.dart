// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textfields.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/themes/light_mode.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // logo
            Icon(
              Icons.message, size: 60, color: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(height: 50,),

            // Welcome message 
            Text(
              'Welcome back, you have been missed!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
            SizedBox(height: 25,),

            // email text field
            MyTextField(hintText: 'Email', obscureText: false, controller: _emailController,),
            SizedBox(height: 10,),

            // password text field
            MyTextField(hintText: 'Password', obscureText: true, controller: _pwController,),
            SizedBox(height: 25,),

            // login button
            MyButton(text: 'Login',),

          ],
        ),
      ),
    );
  }
}
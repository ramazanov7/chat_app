// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:chat_app/service/auth/auth_service.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textfields.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // tap to go register page
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  // login method
  void login(BuildContext context) async {
    // auth service 
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    } catch (e){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        )
      );
    }
  }

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
            MyButton(text: 'Login', onTap:() => login(context),),
            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?  ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text('Register now', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                )
              ]
              ,
            )

          ],
        ),
      ),
    );
  }
}
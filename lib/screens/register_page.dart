// ignore_for_file: prefer_const_constructors

import 'package:chat_app/service/auth/auth_service.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textfields.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

    // tap to go register page
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

    void register(BuildContext context) {
      final _auth = AuthService();
      
      // password matches
      if (_pwController.text == _confirmPwController.text) {
        try {
          _auth.signUpWithEmailPassword(
        _emailController.text, 
        _pwController.text);
        } catch (e) {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            )
          );
        }
        // if passwords don't match
      } else {
        showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: Text('Passwords do not match!'),
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
              "Let's create an account for you",
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
            SizedBox(height: 10,),

            // confirm password text field
            MyTextField(hintText: 'Confirm password', obscureText: true, controller: _confirmPwController,),
            SizedBox(height: 25,),

            // login button
            MyButton(text: 'Register', onTap: () => register(context)),
            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?  ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text('Login', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
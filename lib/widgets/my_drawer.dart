// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/screens/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message, 
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                )
              ),

              // home list tile 
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text('H O M E'),
                  leading: Icon(Icons.home),
                  onTap: () {
                    // pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              // settings
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text('S E T T I N G S'),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    // pop the drawer 
                    Navigator.pop(context);

                    // navigate to settings page 
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => SettingsPage()
                      )
                    );
                  },
                ),
              ),
                ],
              ),

          // logout 
          Padding(
            padding: EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: logout,
            ),
          ),
          
        ],
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors


import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/service/auth/auth_service.dart';
import 'package:chat_app/service/chat/chat_service.dart';
import 'package:chat_app/widgets/my_drawer.dart';
import 'package:chat_app/widgets/user_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // built a list of users except for the current logged in user 
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(), 
      builder: (context, snapshot) {
        // error
        if(snapshot.hasError) {
          return Text('Error');
        }

        // loading 
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        // return list view
        return ListView(
          children: snapshot.data!
          .map<Widget>((userdata) => _buildUserListItem(userdata, context))
          .toList(),
        );
      }
    );
  }

  // build individual list tile for user 
  Widget _buildUserListItem (
    Map<String,dynamic> userdata, BuildContext context) {
    
    // display all users except current user 
    if(userdata['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
      text: userdata["email"],
      onTap: () {
        // tapped on a user -> go to chat page
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userdata["email"],
              receiverID: userdata['uid'],
            ),
          )
        );
      },
      );
    } else {
      return Container();
    }
  }
}
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chat_app/service/auth/auth_service.dart';
import 'package:chat_app/service/chat/chat_service.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/my_textfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller 
  final TextEditingController _messageController = TextEditingController();

  // chat, auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // for textField focus
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add listener to focus node 
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up 
        // then the amount of remaining space will be calculated,
        // then scroll down
        Future.delayed(
         Duration(microseconds: 500),
         () => scrollDown(), 
        );
      }
    });

    // wait a bit for listView to be built, then scroll to bottom
    Future.delayed(
      Duration(microseconds: 500), () => scrollDown()
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller 
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, 
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // send message 
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send the message 
      await _chatService.sendMessage(widget.receiverID, _messageController.text);

      // clear text controller 
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: _buildMessageList()
          ),

          // user input 
          _buildMessageInput()
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverID, senderID), 
      builder: ((context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Text('error');
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('loading');
        }

        // return list view
        return ListView(
          controller: _scrollController,
          children: 
            snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      })
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user 
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data['message'], 
            isCurrentUser: isCurrentUser,),
        ],
      )
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          // text field should take up most of the space
          Expanded(
            child: MyTextField(
              hintText: "Type a message", 
              obscureText: false, 
              controller: _messageController,
              focusNode: focusNode
            ),

          ),
      
          // send button 
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage, 
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.white,
                )
            )
          )
        ],
      ),
    );
  }
}
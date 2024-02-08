import 'package:flutter/material.dart';
import '../Controller/chat_page.dart';

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: ChatPage(),
      ),
    );
  }
}

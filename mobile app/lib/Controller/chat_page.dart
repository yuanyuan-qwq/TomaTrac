import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart';

import 'API.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final SpeechToText _speechToText = SpeechToText();

  @override
  void initState() {
    super.initState();
    _messages.add({
      'sender': 'Bot',
      'message':
          "Welcome to tomaBot! Let's talk about tomatoes.\nHere some interest you need to know:\n1.1 Watering & Hardiness\n1.2 Sunlight Conditions\n1.3 Soil Requirement\n2. How to Plant Tomato\n3. When to Water My Tomato\n4.How to Feed Tomato\n5.How to Prune Tomato\n6.How to Harvest Tomato"
    });
  }

  Future<void> _sendMessage(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'User', 'message': text});
        _controller.clear();
      });

      final response = await http.post(
        Uri.parse('http://$FastapiKey/chat?text=$text'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'text': text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> message = jsonDecode(response.body);

        setState(() {
          _messages.add({'sender': 'Bot', 'message': message['response']});
        });
      } else {
        throw Exception('Failed to load response');
      }
    }
  }

  final ValueNotifier<bool> _isListening = ValueNotifier<bool>(false);

  void _startListening() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setState(() {
        _isListening.value = true; // Update the listening state
      });

      bool isListening = await _speechToText.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        },
      );
    } else {
      print('The user denied the use of speech recognition.');
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "ChatBot",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: _buildMessages(),
              ),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  List<Widget> _buildMessages() {
    return _messages.map((message) {
      return Row(
        mainAxisAlignment: message['sender'] == 'User'
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          if (message['sender'] == 'Bot')
            CircleAvatar(
                backgroundImage: AssetImage('assets/icon/tomabot.jpg')),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: message['sender'] == 'User'
                    ? Colors.blue[200]
                    : Colors.green[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message['message']!,
                style: TextStyle(color: Colors.black, fontSize: 16),
                softWrap: true,
              ),
            ),
          ).animate().fade(duration: 500.ms),
          if (message['sender'] == 'User')
            CircleAvatar(backgroundImage: AssetImage('assets/icon/user.png')),
        ],
      );
    }).toList();
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            ValueListenableBuilder<bool>(
              valueListenable: _isListening,
              builder: (context, isListening, child) {
                return IconButton(
                  icon: Icon(
                    isListening ? Icons.stop : Icons.mic,
                    color: Colors.blue[800],
                  ).animate().fade(),
                  onPressed: () {
                    isListening ? _stopListening() : _startListening();
                  },
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Colors.blue[800]),
              onPressed: () {
                _sendMessage(_controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

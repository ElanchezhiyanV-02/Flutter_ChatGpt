import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginbc/pages/threedots.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chatmessage.dart';
import 'navbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  ChatGPT? chatGPT;
  StreamSubscription? _subscription;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    chatGPT = ChatGPT.instance;
  }
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage(){
    ChatMessage message = ChatMessage(text: _controller.text, sender: user.displayName!);
    setState(() {
      _messages.insert(0,message);
      _isTyping = true;
    });
    _controller.clear();

    final request = CompleteReq(prompt: message.text, model: kTranslateModelV3, max_tokens: 200);

    _subscription = chatGPT!.builder("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")
    .onCompleteStream(request: request)
    .listen((response) {
      Vx.log(response!.choices[0].text);
      ChatMessage botMessage = ChatMessage(
        text: response!.choices[0].text, sender: "bot");

      setState(() {
        _isTyping = false;
        _messages.insert(0, botMessage);
      });
    });

  }
  Widget _buildTextComposer(){
    return Row(
      children: [
        Expanded(child: TextField(
          controller: _controller,
          onSubmitted: (value) => _sendMessage(),
          decoration: InputDecoration.collapsed(hintText: "Send a Message"),
        ),
        ),
        IconButton(
          onPressed: () => _sendMessage(),
          icon: Icon(Icons.send)
        )
      ],
    ).px16 ();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(),
      appBar: AppBar(title: Text("ChatGPT")),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(child:ListView.builder(
              reverse: true,
              padding: Vx.m8,
            itemCount: _messages.length,
            itemBuilder: (context, index){
            return _messages[index];

            },),
            ),
            if(_isTyping) const ThreeDots(),
            const Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,),
                child: _buildTextComposer(),
            )
          ],
        ),
      ),
    );
  }
}
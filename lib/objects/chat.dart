import 'package:flutter/material.dart';

import './message.dart';

class Chat {
  Chat({
    required this.title,
    required this.index,
  });

  List<Message> messages = <Message>[];

  String title;
  int index;

  void addMessage({required Widget bubble}) {
    Message message = Message(bubble: bubble);
    messages.add(message);
  }

  List<Message> getMessagesList() {
    return messages.reversed.toList();
  }

  void setTitle({required newTitle}) {
    title = newTitle;
  }
}

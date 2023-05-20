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

  // void pinChat() {
  //   _changePriority();
  // }

  // void _changePriority() {
  //   if (_priority == 0) {
  //     _priority = 1;
  //   } else {
  //     _priority = 0;
  //   }
  // }

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

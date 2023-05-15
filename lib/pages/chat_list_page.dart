import 'package:chat_gpt_task/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../objects/chat.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('Whats up gpt'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        // SizedBox(width: MediaQuery.of(context).size.width, height: 50),
        const Expanded(child: List()),
        const NavBar(),
      ],
    );
  }
}

// WIDGETS
class List extends StatelessWidget {
  const List({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var chats = appState.chats;

    return ListView(
      children: [
        for (Chat chat in chats) ListItem(chat: chat),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    var itemStyle = ElevatedButton.styleFrom(
      backgroundColor:
          Theme.of(context).colorScheme.background, //const Color(0xFF5D576B),
      side: const BorderSide(width: 4, color: Color(0xFFA29C94)),
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () => {},
        style: itemStyle,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                chat.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD6CFC6)),
              ),
              const Icon(
                Icons.arrow_right_rounded,
                size: 40,
                color: Color(0xFFD6CFC6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.inversePrimary,
              elevation: 0,
              minimumSize: const Size(75, 75),
            ),
            onPressed: () => {appState.addChat(chat: appState.chat)},
            child: const Icon(Icons.add, size: 30),
          ),
        ],
      ),
    );
  }
}

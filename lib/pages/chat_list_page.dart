import 'package:chat_gpt_task/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// PAGES
import '../pages/in_chat_page.dart';

// OBJECTS
import '../objects/chat.dart';

const fontColor = Color(0xFFD6CFC6);

class ChatList extends StatelessWidget {
  const ChatList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: const Text(
              'Whats up gpt?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          const Expanded(child: List()),
          const NavBar(),
        ],
      ),
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
      backgroundColor: Theme.of(context).colorScheme.background,
      side: const BorderSide(width: 2, color: fontColor),
    );

    // var appState = context.watch<AppState>();

    return GestureDetector(
      onPanUpdate: (details) => {
        if (details.delta.dx > 0) {_showMyDialog(context: context)}
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: itemStyle,
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatView(chat: chat)),
            ),
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  chat.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: fontColor),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                  size: 40,
                  color: fontColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog({required BuildContext context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            'Are you sure you want to delete this chat?',
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                //! HOW DO I DELETE FROM HERE? <--------------------------------
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

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
            onPressed: () =>
                {appState.initChat(), appState.addChat(chat: appState.c)},
            child: const Icon(Icons.add, size: 30),
          ),
        ],
      ),
    );
  }
}

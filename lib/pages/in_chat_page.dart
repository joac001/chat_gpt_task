import 'package:flutter/material.dart';

import '../objects/chat.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => {
        if (details.delta.dx > 0) {Navigator.pop(context)}
      },
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // TITLE
            ChatTitle(chat: chat),

            // MESAGGES VIEW
            Expanded(child: ListView()),

            // PROMT INPUT BELOW
            const Prompt(),
          ],
        ),
      ),
    );
  }
}

// WIDGETS

class ChatTitle extends StatelessWidget {
  const ChatTitle({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            height: 50,
            child: Card(
              child: Text(
                chat.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),

          //EDIT BUTTON
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditTitle()))
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(45, 45)),
            child: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}

class EditTitle extends StatelessWidget {
  const EditTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                height: 50,
                child: Container(
                  alignment: Alignment.center,
                  child: const Card(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter new name...',
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => {},
                style:
                    ElevatedButton.styleFrom(maximumSize: const Size(45, 45)),
                child: const Icon(Icons.done),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    );
  }
}

class Prompt extends StatelessWidget {
  const Prompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            height: 50,
            child: Container(
              alignment: Alignment.center,
              child: const Card(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Prompt...',
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(45, 45)),
            onPressed: () => {},
            child: const Icon(Icons.send),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

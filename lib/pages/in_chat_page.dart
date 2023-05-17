import 'package:chat_gpt_task/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTitle(chat: chat),
                ),
              ),
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
  const EditTitle({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final myController = TextEditingController();
    double halfWidth = MediaQuery.of(context).size.width / 4;

    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.red,
              margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'The name of the chat will update once you close the chat',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: halfWidth,
                right: halfWidth,
              ),
              child: Card(
                child: TextField(
                  controller: myController,
                  decoration: const InputDecoration(labelText: 'New name:'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 5),
                  child: ElevatedButton(
                    onPressed: () => {
                      chat.setTitle(newTitle: myController.text),
                      appState.update(),
                      Navigator.pop(context),
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(45, 45),
                    ),
                    child: const Icon(Icons.done),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 5),
                  child: ElevatedButton(
                    onPressed: () => {Navigator.pop(context)},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(45, 45),
                    ),
                    child: const Icon(Icons.cancel),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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

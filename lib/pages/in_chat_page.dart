import 'package:chat_bubbles/chat_bubbles.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            // TITLE
            ChatTitle(chat: chat),

            // MESAGGES VIEW
            Expanded(child: MessageList(chat: chat)),

            // PROMT INPUT BELOW
            Prompt(chat: chat, currentChatView: this),
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
              child: Center(
                child: Text(
                  chat.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),

          //EDIT BUTTON
          ElevatedButton(
            onPressed: () => {
              _showMyDialog(context: context),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTitle(chat: chat),
                ),
              )
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(45, 45)),
            child: const Icon(Icons.edit),
          ),
        ],
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
            'This name will be updated once you close this chat!',
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
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
                      if (myController.text.isNotEmpty)
                        {
                          chat.setTitle(newTitle: myController.text),
                          appState.update(),
                        },
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

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 140,
      child: ListView(
        children: [
          for (var bubble in chat.bubbleList) bubble,
        ],
      ),
    );
  }
}

class Prompt extends StatelessWidget {
  const Prompt({super.key, required this.chat, required this.currentChatView});

  final Chat chat;
  final ChatView currentChatView;

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    var appState = context.watch<AppState>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            height: 100,
            child: Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Card(
                  child: TextField(
                    controller: myController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 5, bottom: 15, top: 15, right: 5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(45, 45)),
            onPressed: () => {
              sendMessage(
                  controller: myController, chat: chat, context: context),
              appState.update(),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => currentChatView),
              ),
            },
            child: const Icon(Icons.send),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  void sendMessage(
      {required TextEditingController controller,
      required Chat chat,
      required BuildContext context}) {
    if (controller.text.isNotEmpty) {
      Widget bubble = BubbleSpecialThree(
        text: controller.text,
        color: Colors.blueGrey,
        tail: true,
        isSender: true,
        textStyle: const TextStyle(color: Colors.white, fontSize: 16),
      );
      chat.addMessage(bubble: bubble);
    }
  }
}

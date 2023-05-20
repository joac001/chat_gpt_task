import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:chat_gpt_task/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../objects/chat.dart';
import '../objects/gpt.dart';

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
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.transparent),
                      onPressed: () => {Navigator.pop(context)},
                      child: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      chat.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
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
            'The name will be updated once you close the chat or send a new message!',
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
        reverse: true,
        children: [
          for (var message in chat.getMessagesList()) message.bubble,
        ],
      ),
    );
  }
}

class Prompt extends StatelessWidget {
  const Prompt({
    super.key,
    required this.chat,
    required this.currentChatView,
  });

  final Chat chat;
  final ChatView currentChatView;

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    var appState = context.watch<AppState>();

    late String currentPrompt;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            height: 100,
            child: Container(
              alignment: Alignment.center,
              child: Card(
                child: TextField(
                  controller: myController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Prompt...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.only(left: 5, bottom: 15, top: 15, right: 5),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(45, 45)),
            onPressed: () => {
              if ((myController.text).isNotEmpty)
                {
                  currentPrompt = myController.text,
                  sendMessage(
                    prompt: currentPrompt,
                    chat: chat,
                    context: context,
                    isSender: true,
                    appState: appState,
                  ),
                  sendMessage(
                    prompt: currentPrompt,
                    chat: chat,
                    context: context,
                    isSender: false,
                    appState: appState,
                  ),
                }
            },
            child: const Icon(Icons.send),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Future<void> sendMessage({
    required String prompt,
    required Chat chat,
    required BuildContext context,
    required bool isSender,
    required AppState appState,
  }) async {
    if (!isSender) {
      dynamic response = await GPT.sendMessage(prompt: prompt);

      Future.delayed(const Duration(seconds: 2), () async {
        String text = response['choices'][0]['text'];
        text = text.trim();

        Widget bubble = BubbleSpecialThree(
          text: text,
          color: const Color(0xFF2A5B74),
          tail: true,
          isSender: isSender,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        );

        chat.addMessage(bubble: bubble);
        _updateChat(context: context, appState: appState, chat: chat);
      });
    } else {
      Widget bubble = BubbleSpecialThree(
        text: prompt,
        color: const Color(0xFF45758B),
        tail: true,
        isSender: isSender,
        textStyle: const TextStyle(color: Colors.white, fontSize: 16),
      );

      chat.addMessage(bubble: bubble);
      _updateChat(context: context, appState: appState, chat: chat);
    }
  }

  void _updateChat(
      {required BuildContext context,
      required AppState appState,
      required chat}) {
    appState.update();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            ChangeNotifierProvider<AppState>.value(
          value: Provider.of<AppState>(context),
          child: ChatView(chat: chat),
        ),
      ),
    );
  }
}

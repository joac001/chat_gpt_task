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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 15, right: 15, left: 15),
                  child: Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        chat.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // MESAGGES VIEW
            Expanded(child: ListView()),

            // PROMT INPUT BELOW
            Padding(
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
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Prompt...',
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(45, 45)),
                    onPressed: () => {},
                    child: const Icon(Icons.send),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}

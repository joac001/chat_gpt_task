import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// PAGES
import './pages/chat_list_page.dart';

// OBJECTS
import 'objects/chat.dart';

const primaryColor = Color(0xFF342F5C);
const backgroundColor = Color(0xFF41296D);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(context: context),
      child: MaterialApp(
        title: 'Chat-gpt task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            background: backgroundColor,
          ),
        ),
        home: const ChatList(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  AppState({
    required this.context,
  });

//? DON'T LIKE THIS
  BuildContext context;

  var chats = <Chat>[];

//! DEBUG <---------------------------------------------------------------------
  late Chat c;
  void initChat() {
    c = Chat(title: 'New chat', index: chats.length);
  }

  void update() {
    notifyListeners();
  }

  void addChat({required Chat chat}) {
    chats.add(chat);
    //! chats.clear(); <--------------------------------------------------------
    notifyListeners();
  }

  void removeChat({required chat}) {
    for (Chat c in chats) {
      if (chat.index == c.index) {
        chats.removeAt(c.index);
        notifyListeners();
        break;
      }
    }
  }
}

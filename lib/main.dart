import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// PAGES
import './pages/chat_list_page.dart';

// OBJECTS
import 'objects/chat.dart';

const primaryColor = Color.fromARGB(255, 32, 96, 148); // AppBar - Icons
const backgroundColor = Color(0xFF4688AC); // Scaffold background

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
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
  var chats = <Chat>[];

  late Chat c;
  void initChat() {
    c = Chat(title: 'New chat', index: chats.length);
  }

  void update() {
    notifyListeners();
  }

  void addChat({required Chat chat}) {
    chats.add(chat);
    notifyListeners();
  }

  void removeChat({required chat}) {
    for (Chat c in chats) {
      chats.remove(c);
      notifyListeners();
      break;
    }
  }
}

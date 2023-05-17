class Chat {
  Chat({
    required this.title,
    required this.index,
  });

  List<String>? messages;
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

  void setTitle({required newTitle}) {
    title = newTitle;
  }
}

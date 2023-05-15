class Chat {
  Chat({
    required this.title,
  });

  List<String>? messages;
  String title;
  int _priority = 0;

  void pinChat() {
    _changePriority();
  }

  void _changePriority() {
    if (_priority == 0) {
      _priority = 1;
    } else {
      _priority = 0;
    }
  }
}

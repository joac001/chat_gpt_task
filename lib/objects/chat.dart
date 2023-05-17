class Chat {
  Chat({
    required this.title,
    required this.appState,
  });

  List<String>? messages;
  String title;
  int _priority = 0;

//? DON'T LIKE IT <-------------------------------------------------------------
  final appState;

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

  void setTitle({required newTitle}) {
    title = newTitle;
//? DON'T LIKE IT, SHOULDENT : HAVE TO UPDATE STATE FROM HERE <-----------------
    appState.update();
  }
}

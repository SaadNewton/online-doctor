
import 'package:doctoworld_doctor/screens/chat_page.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String chatScreen = 'chat_screen';

  Map<String, WidgetBuilder> routes() {
    return {
      chatScreen: (context) => ChatScreen(),

    };
  }
}

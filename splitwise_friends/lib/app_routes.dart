import 'package:flutter/material.dart';
import 'splitwise_friends_tab_container_screen.dart';

class AppRoutes {
  static const String splitwiseFriendsTabContainerScreen = '/splitwise_friends_tab_container_screen';
  static const String initialRoute = splitwiseFriendsTabContainerScreen;

  static Map<String, WidgetBuilder> routes = {
    splitwiseFriendsTabContainerScreen: (context) => SplitwiseFriendsTabContainerScreen(),
  };
}
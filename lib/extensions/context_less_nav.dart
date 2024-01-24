import 'package:flutter/material.dart';

extension EasyNavigator on BuildContext {
  NavigatorState get nav {
    return Navigator.of(this);
  }
}

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeItem { LIGHT, DARK }

class ThemeBloc {
  final BehaviorSubject<bool> _themController =
      BehaviorSubject<bool>();

  bool defaultItem = true;
  Stream<bool> get itemStream => _themController.stream;

  Future<void> pickItem(bool i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (i) {
      _themController.sink.add(true);
      prefs.setBool("userTheme", true);
    } else {
      _themController.sink.add(false);
      prefs.setBool("userTheme", false);

    }
  }

  Future<void> getUserTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userTheme =
        prefs.getBool("userTheme") != null ? prefs.getBool("userTheme") : true;
    pickItem(userTheme);
  }

  close() {
    _themController?.close();
  }
}

final themeBloc = ThemeBloc();

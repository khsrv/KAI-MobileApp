import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/theme_bloc.dart';
import 'package:kai_mobile_app/screens/main_screen.dart';
import 'package:kai_mobile_app/style/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: themeBloc.itemStream,
      initialData: themeBloc.defaultItem,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data) {
          return MaterialApp(
            title: 'KaiMobile',
            theme: themeLight,
            home: MainScreen(),
          );
        } else {
          return MaterialApp(
            title: 'KaiMobile',
            theme: themeDark,
            home: MainScreen(),
          );
        }
      
        }
      
    );
  }
}

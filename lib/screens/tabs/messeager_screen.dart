import 'package:flutter/material.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

class MessengerScreen extends StatefulWidget {
  @override
  _MessengerScreenState createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child:Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Сообщения",
            style: kAppBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Style.Colors.mainColor,
          shadowColor: Colors.grey[100],
        ),
        body: Center(child: Text("Нет данных")),
      ),
    );
  }
}

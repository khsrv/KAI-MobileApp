import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/screens/services/activity_screen.dart';
import 'package:kai_mobile_app/screens/services/brs_screen.dart';
import 'package:kai_mobile_app/screens/services/control_screen.dart';
import 'package:kai_mobile_app/screens/services/doc_screen.dart';
import 'package:kai_mobile_app/screens/services/exams_screen.dart';
import 'package:kai_mobile_app/screens/services/lesson_screen.dart';

import 'package:kai_mobile_app/screens/services/map_screen.dart';
import 'package:kai_mobile_app/screens/services/my_group_screen.dart';
import 'package:kai_mobile_app/screens/services/service_menu_screen.dart';


class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("onWillPop");
        serviceMenu..backToMenu();
        return false;
        },
      child: StreamBuilder(
        stream: serviceMenu.itemStream,
        initialData: serviceMenu.defaultItem,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<ServiceMenuItem> snapshot) {
          switch(snapshot.data){
            case ServiceMenuItem.MENU:
              return ServiceMenuScreen();
            case ServiceMenuItem.LESSON:
              return LessonsScreen();
            case ServiceMenuItem.EXAMS:
              return ExamsScreen();
            case ServiceMenuItem.MY_GROUP:
              return MyGroupScreen();
            case ServiceMenuItem.BRS:
              return BRSScreen();
            case ServiceMenuItem.MAP:
              return MapScreen();
            case ServiceMenuItem.ACTIVITY:
              return ActivityScreen();
            case ServiceMenuItem.DOC:
              return DocScreen();
            case ServiceMenuItem.CONTROL:
              return ControlScreen();
          }
        }
      ),
    );
  }
}

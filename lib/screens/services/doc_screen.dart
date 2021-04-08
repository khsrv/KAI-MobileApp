import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class DocScreen extends StatefulWidget {
  @override
  _DocScreenState createState() => _DocScreenState();
}

class _DocScreenState extends State<DocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            serviceMenu..backToMenu();
          },
        ),
        title: Text(
          "Документы",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: newMethod(context, docUrls["УСТАВ"], "Устав КНИТУ-КАИ"),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: newMethod(context, docUrls["АККРЕД"],
                "Свидетельство о государственной аккредитации №2940 от 14 ноября 2018г"),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: newMethod(context, docUrls["ПВРСТУД"],
                "Правила внутреннего распорядка обучающихся"),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: newMethod(context, docUrls["ПВРСТУДОБЩ"],
                "Правила внутреннего распорядка для проживающих в общежитиях КНИТУ-КАИ"),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: newMethod(context, docUrls["ПСОБ"],
                "Положение о стипендиальном обеспечении и других видах материальной поддержки обучающихся"),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: newMethod(
                context, docUrls["МАТПОМ"], "Заявление на мат. помощь"),
          ),
        ],
      ),
    );
  }

  Container newMethod(BuildContext context, String url, String title) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: Theme.of(context).accentColor,
              style: BorderStyle.solid,
              width: 1.5),
          color: Theme.of(context).bannerTheme.backgroundColor),
      padding: EdgeInsets.all(10),
      //height: 50,
      child: GestureDetector(
        onTap: () {
          _openUrl(url);
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: Theme.of(context).textTheme.headline3),
        ),
      ),
    );
  }

  _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

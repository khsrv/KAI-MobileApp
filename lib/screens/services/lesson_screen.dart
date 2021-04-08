import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/day_bloc.dart';
import 'package:kai_mobile_app/bloc/get_lessons_bloc.dart';
import 'package:kai_mobile_app/bloc/week_bloc.dart';
import 'package:kai_mobile_app/elements/auth_button.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/lesson_model.dart';
import 'package:kai_mobile_app/model/lessons_response.dart';


class LessonsScreen extends StatefulWidget {
  @override
  _LessonsScreenState createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  @override
  void initState() {
    getLessonsBloc..getLessons();
    weekBloc..getCurrWeek();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: dayWeekBloc.currDay.index,
      child: Column(
        children: [
          _buildWeekCheck(),
          Container(
            color: Theme.of(context).primaryColor,
            child: PreferredSize(
              preferredSize: null,
              child: TabBar(
                
                tabs: [
                  Tab(
                    text: "ПН",
                  ),
                  Tab(
                    text: "ВТ",
                  ),
                  Tab(
                    text: "СР",
                  ),
                  Tab(
                    text: "ЧТ",
                  ),
                  Tab(
                    text: "ПТ",
                  ),
                  Tab(
                    text: "СБ",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              
              children: [
                _buildLessonsView(1),
                _buildLessonsView(2),
                _buildLessonsView(3),
                _buildLessonsView(4),
                _buildLessonsView(5),
                _buildLessonsView(6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsView(int day) {
    return StreamBuilder(
        stream: getLessonsBloc.subject.stream,
        builder: (context, AsyncSnapshot<LessonsResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              if (snapshot.data.error == "Авторизуйтесь") {
                return buildAuthButton();
              }
              return Center(
                child: Text(snapshot.data.error),
              );
            }
            return _buildLessonsList(snapshot.data, day);
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return buildLoadingWidget();
          }
        });
  }

  Widget _buildLessonsList(LessonsResponse lessonsResponse, int dayWeek) {
    List<LessonModel> lessons = lessonsResponse.lessons;
    return StreamBuilder(
        stream: weekBloc.weekStream,
        initialData: weekBloc.currWeek,
        builder: (context, AsyncSnapshot<WeekItem> snapshot) {
          print("snap");
          print(snapshot.data);
          return ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return lessons[index].dayNum == dayWeek &&
                        (lessons[index].dayEven == snapshot.data ||
                            lessons[index].dayEven == null)
                    ? _buildLessonItem(lessons[index])
                    : Container();
              });
        });
  }

  Widget _buildWeekCheck() {
    return StreamBuilder(
        stream: weekBloc.weekStream,
        initialData: weekBloc.currWeek,
        builder: (context, AsyncSnapshot<WeekItem> snapshot) {
          return Container(
            color: Theme.of(context).primaryColor,
            height: 60,
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    weekBloc.pickWeek(0);
                  },
                  child: Container(
                    
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Четная",
                       style: snapshot.data == WeekItem.EVEN
                            ? Theme.of(context).textTheme.headline3
                            : Theme.of(context).textTheme.headline4,
                            )
                    ),
                  ),
                )),
                SizedBox(
                  height: 25,
                  width: 1,
                  child: Container(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    weekBloc.pickWeek(1);
                  },
                  child: Container(
          
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Нечетная",
                        style: snapshot.data == WeekItem.UNEVEN
                            ? Theme.of(context).textTheme.headline3
                            : Theme.of(context).textTheme.headline4,
                            ),
                    ),
                  ),
                )),
              ],
            ),
          );
        });
  }

  Widget _buildLessonItem(LessonModel lesson) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Card(
              child: Container(
          height: 110,
          
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          lesson.dayTime,
                          style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Text(
                          "Здание: ${lesson.buildNum}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Ауд: ${lesson.audNum}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.disciplineName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${lesson.disciplineType}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${lesson.prepodName}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        lesson.dayDate != null
                            ? Text(
                                "${lesson.dayDate}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Theme.of(context).accentColor,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

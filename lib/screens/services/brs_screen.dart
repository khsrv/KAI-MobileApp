import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/get_brs_lesson_bloc.dart';
import 'package:kai_mobile_app/bloc/get_semester_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/elements/auth_button.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/lesson_brs_model.dart';
import 'package:kai_mobile_app/model/lesson_brs_response.dart';
import 'package:kai_mobile_app/model/semester_brs_model.dart';
import 'package:kai_mobile_app/model/semester_response.dart';

class BRSScreen extends StatefulWidget {
  @override
  _BRSScreenState createState() => _BRSScreenState();
}

class _BRSScreenState extends State<BRSScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    getSemestrBloc..getSemestr();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getSemestrBloc.subject,
        builder: (context, AsyncSnapshot<SemesterResponse> snapshot) {
          if (snapshot.hasData) {
            /*if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              if (snapshot.data.error == "Авторизуйтесь") {
                return buildAuthButton();
              }
              return Center(
                child: Text(snapshot.data.error),
              );
            }*/
            if (snapshot.data is SemesterResponseUserUnLogged) {
              return buildAuthButton();
            } else if (snapshot.data is SemesterResponseWithError) {
              return Center(
                child: Text(snapshot.data.error),
              );
            }
            getBRSLessonsBloc..getBrsLessons(snapshot.data.semesters.length);
            return DefaultTabController(
              length: snapshot.data.semesters.length,
              initialIndex: snapshot.data.semesters.length - 1,
              child: Scaffold(
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
                    "БРС",
                  ),
                  centerTitle: true,
                  bottom: TabBar(
                    labelColor: Theme.of(context).accentColor,
                    tabs: snapshot.data.semesters.map((SemestrModel semester) {
                      return Tab(
                        text: semester.semesterNum.toString(),
                      );
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  children:
                      snapshot.data.semesters.map((SemestrModel semester) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      "Предмет",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      "Аттестация",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Итог",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                              child: _buildBRSView(semester.semesterNum)),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Ошибка"),
            );
          } else {
            return buildLoadingWidget();
          }
        });
  }

  Widget _buildBRSView(int semsetrNum) {
    return StreamBuilder(
        stream: getBRSLessonsBloc.subject.stream,
        builder: (context, AsyncSnapshot<LessonsBRSResponsesList> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is LessonsBRSResponsesListLoading) {
              return buildLoadingWidget();
            } else if (snapshot.data is LessonsBRSResponsesListOK) {
              return _buildBRSList(snapshot
                  .data.lessonsBRSResponsesList[semsetrNum - 1].lessonsBRS);
            } else {
              return Container();
            }
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return buildLoadingWidget();
          }
        });
  }

  Widget _buildBRSList(List<LessonBRSModel> brsList) {
    return ListView.separated(
        separatorBuilder: (ctx, index) => Divider(color: Colors.black),
        itemCount: brsList.length,
        itemBuilder: (context, index) {
          return _buildBRSItem(brsList[index]);
          //Text(brsList[index].disciplineName);
        });
  }

  Widget _buildBRSItem(LessonBRSModel lessonBRSModel) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 8),
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  lessonBRSModel.disciplineName,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 14,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lessonBRSModel.att1.toString(),
                            style: TextStyle(),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "из ${lessonBRSModel.maxAtt1}",
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lessonBRSModel.att2.toString(),
                            style: TextStyle(),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "из ${lessonBRSModel.maxAtt2}",
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lessonBRSModel.att3.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "из ${lessonBRSModel.maxAtt3}",
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Text(
                "${lessonBRSModel.finBall > 0 ? lessonBRSModel.finBall : lessonBRSModel.att1 + lessonBRSModel.att2 + lessonBRSModel.att3}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: lessonBRSModel.finBall > 50
                      ? Colors.lightGreen
                      : Theme.of(context).disabledColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

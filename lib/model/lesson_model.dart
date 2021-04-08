
import 'package:kai_mobile_app/bloc/week_bloc.dart';

class LessonModel{
  int dayNum;
  String dayTime;
  WeekItem dayEven;
  String dayDate;
  String disciplineName;
  String disciplineType;
  String audNum;
  String buildNum;
  String prepodName;
  String orgName;

  LessonModel.fromJson(dynamic data){
    this.dayNum = int.parse(data["DayNum"].toString().trim());
    this.dayTime = data["DayTime"].toString().trim();
    this.dayEven = setWeek(data["DayDate"].toString().trim());
    this.disciplineName = data["DisciplineName"].toString().trim();
    this.disciplineType = setDisciplineType(data["DisciplineType"].toString().trim());
    this.audNum = data["AudNum"].toString().trim();
    this.buildNum = data["BuildNum"].toString().trim();
    this.prepodName = data["PrepodName"].toString().trim();
    this.orgName = data["OrgName"].toString().trim();
  }

  WeekItem setWeek(String week){
    if(week == "чет"){
      return WeekItem.EVEN;
    }else if(week == "неч"){
      return WeekItem.UNEVEN;
    }else if(week.length>0){
      this.dayDate = week;
      return null;
    } else{
      return null;
    }
  }

  String setDisciplineType(String disciplineType){
    if(disciplineType == "лек"){
      return "Лекция";
    }else if(disciplineType == "л.р."){
      return "Лабораторная работа";
    }else if(disciplineType == "пр"){
      return "Практика";
    } else{
      return disciplineType;
    }
  }
}
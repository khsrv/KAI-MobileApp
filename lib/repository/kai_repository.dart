import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kai_mobile_app/model/exams_response.dart';
import 'package:kai_mobile_app/model/group_mate_respose.dart';
import 'package:kai_mobile_app/model/lesson_brs_response.dart';
import 'package:kai_mobile_app/model/lessons_response.dart';
import 'package:kai_mobile_app/model/semester_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KaiRepository {
  static String mainUrl = "http://app.kai.ru/api";
  final Dio _dio = Dio();

  // Future<UserResponse> userAuth(String login, String password) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var params = {
  //     "authToken": "{token}",
  //     "runParams": "{\"PipelineId\":270701192,"
  //         "\"StepId\":10,"
  //         "\"OutputName\":\"Row\","
  //         "\"Variables\":{"
  //         "\"Login\":\"$login\","
  //         "\"Password\":\"$password\"}"
  //         "}",
  //   };
  //   try {
  //     Response response = await _dio.get(mainUrl, queryParameters: params);
  //     var data = jsonDecode(response.data);
  //     var rest = data["Data"] as List;
  //     //print(data);
  //     if (rest.isNotEmpty) {
  //       prefs.setString("login", login);
  //       prefs.setString("password", password);
  //       prefs.setString("userData", jsonEncode(data["Data"][0]));
  //       print(jsonEncode(data["Data"][0]));
  //       return UserResponse.fromJson(data["Data"][0]);
  //     } else {
  //       print("Неверный логин или пароль");
  //       return UserResponse.withError("Неверный логин или пароль");
  //     }
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return UserResponse.withError("Нет сети");
  //   }
  // }

  // Future<UserResponse> userAuthLocal() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String login = prefs.getString("login");
  //   String password = prefs.getString("password");
  //   var dataSP = prefs.getString("userData") != null ? jsonDecode(
  //       prefs.getString("userData")) : null;
  //   if (login != null && password != null && dataSP != null) {
  //     var params = {
  //       "authToken": "{token}",
  //       "runParams": "{\"PipelineId\":270701192,"
  //           "\"StepId\":10,"
  //           "\"OutputName\":\"Row\","
  //           "\"Variables\":{"
  //           "\"Login\":\"$login\","
  //           "\"Password\":\"$password\"}"
  //           "}",
  //     };
  //     try {
  //       Response response = await _dio.get(mainUrl, queryParameters: params);
  //       var data = jsonDecode(response.data);
  //       var rest = data["Data"] as List;
  //       //print(data);
  //       if (rest.isNotEmpty) {
  //         prefs.setString("userData", jsonEncode(data["Data"][0]));
  //         return UserResponse.fromJson(data["Data"][0]);
  //       } else {
  //         print("Авторизуйтесь");
  //         return UserResponse.withError("Авторизуйтесь");
  //       }
  //     } catch (error) {
  //       //print("Exception occured: $error stackTrace: $stacktrace");
  //       return UserResponse.fromJson(dataSP);
  //     }
  //   } else {
  //     return UserResponse.withError("Авторизуйтесь");
  //   }
  // }

  // Future<UserResponse> userLogOut(int semestrNum) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   for(int i = 1;i<semestrNum;i++){
  //     prefs.remove("brs$i");
  //   }
  //   prefs.remove("login");
  //   prefs.remove("password");
  //   prefs.remove("userData");
  //   prefs.remove("examssData");
  //   prefs.remove("lessonsData");
  //   prefs.remove("semestr");
  //   prefs.remove("group");
  //   prefs.remove("userTheme");
  //   return UserResponse.withError("Авторизуйтесь");
  // }

  Future<LessonsResponse> getLessons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var lessonsSP = prefs.getString("lessonsData") != null
        ? jsonDecode(prefs.getString("lessonsData"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":145877938,"
            "\"StepId\":3,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\","
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);

        var data = jsonDecode(response.data.replaceAll(RegExp(r"\\"), "/"));
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("${data["Data"][0]} test");
          prefs.setString("lessonsData", jsonEncode(data));
          return LessonsResponse.fromJson(data);
        } else {
          return LessonsResponse.withError("Авторизуйтесь");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (lessonsSP != null) {
          return LessonsResponse.fromJson(lessonsSP);
        }
        return LessonsResponse.withError("Авторизуйтесь");
      }
    } else {
      print("Требуется авторизация");
      return LessonsResponse.withError("Авторизуйтесь");
    }
  }

  Future<ExamsResponse> getExams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var lessonsSP = prefs.getString("examssData") != null
        ? jsonDecode(prefs.getString("examssData"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":145877940,"
            "\"StepId\":3,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\","
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);

        var data = jsonDecode(response.data.replaceAll(RegExp(r"\\"), "/"));
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("${data["Data"][0]} test");
          prefs.setString("examssData", jsonEncode(data));
          return ExamsResponse.fromJson(data);
        } else {
          return ExamsResponse.withError("Авторизуйтесь");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (lessonsSP != null) {
          return ExamsResponse.fromJson(lessonsSP);
        }
        return ExamsResponse.withError("Авторизуйтесь");
      }
    } else {
      print("Требуется авторизация");
      return ExamsResponse.withError("Авторизуйтесь");
    }
  }

  Future<SemesterResponse> getSemestr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var semestrSP = prefs.getString("semestr") != null
        ? jsonDecode(prefs.getString("semestr"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":145864128,"
            "\"StepId\":3,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\","
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);
        var data = jsonDecode(response.data);
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("${data["Data"][0]} test");
          prefs.setString("semestr", jsonEncode(data["Data"][0]));
          return SemesterResponseUserLoggedIn(data["Data"][0]);
        } else {
          return SemesterResponseWithError("Нет данных");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (semestrSP != null) {
          return SemesterResponseUserLoggedIn(semestrSP);
        }
        return SemesterResponseUserUnLogged();
      }
    } else {
      print("Требуется авторизация");
      return SemesterResponseUserUnLogged();
    }
  }

  Future<LessonsBRSResponse> getLessonsBRS(int semesterNum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var lessonsBRSSP = prefs.getString("brs$semesterNum") != null
        ? jsonDecode(prefs.getString("brs$semesterNum"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":445063016,"
            "\"StepId\":11,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\",\"Semestr\":\"$semesterNum\""
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);
        var data = jsonDecode(response.data);
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("BRS: ${data["Data"][0]}");
          prefs.setString("brs$semesterNum", jsonEncode(data));
          return LessonsBRSResponseOk(data);
        } else {
          return LessonsBRSResponseWithErrors("Авторизуйтесь");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (lessonsBRSSP != null) {
          return LessonsBRSResponseOk(lessonsBRSSP);
        }
        return LessonsBRSResponseWithErrors("Авторизуйтесь");
      }
    } else {
      print("Требуется авторизация");
      return LessonsBRSResponseWithErrors("Авторизуйтесь");
    }
  }

  Future<GroupMateResponse> getGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var groupSP = prefs.getString("group") != null
        ? jsonDecode(prefs.getString("group"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":145873539,"
            "\"StepId\":6,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\","
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);
        var data = jsonDecode(response.data.replaceAll(RegExp(r"\\"), "/"));
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("${data["Data"][0]} test");
          prefs.setString("group", jsonEncode(data));
          return GroupMateResponse.fromJson(data);
        } else {
          return GroupMateResponse.withError("Нет данных");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (groupSP != null) {
          return GroupMateResponse.fromJson(groupSP);
        }
        return GroupMateResponse.withError("Авторизуйтесь");
      }
    } else {
      print("Требуется авторизация");
      return GroupMateResponse.withError("Авторизуйтесь");
    }
  }
}

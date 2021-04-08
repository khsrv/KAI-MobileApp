import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kai_mobile_app/model/activitys_response.dart';
import 'package:kai_mobile_app/model/news_response.dart';
import 'package:kai_mobile_app/model/report_response.dart';
import 'package:kai_mobile_app/model/reports_response.dart';
import 'package:kai_mobile_app/model/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileRepository {
  static String mainUrl = "https://mobile.kai.ru/";
  static String authUrl = "api/auth/login";
  static String newsUrl = "api/posts/";
  static String reportsUrl = "api/reports/";
  static String activitiesUrl = "api/activities/";
  static String sendReportUrl = "api/reports/";
  static String getDateUrl = "api/date/";
  //Временный токен
  static String userToken =
      "oNdqgXvuPkiHfAEhRhMLJkEQUS3ikuSuZCbhIyz4eNkwnwEia3UudTzjzzPwngffjU4CHDr1X7Ad6gSauhAC4cQ26EglUwgNj6pKBzjkCkZ9JTlK7d5k5XG127T5QJpmU6IjBpftEwxDKC9Ha4ZrfQwQ3leBRZETWDMY20XoDOEqCqIKPVPVeDtEGcgZvAxZ7juYMFTeuT8bxP3vLtJcKTn6QBYNqmnS22ipjsPtHfmx44yKkkKTcKlTxREsUkDT";

  final Dio _dio = Dio();

  Future<UserResponse> userAuth(String login, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {"login": "$login", "password": "$password"};
    print(jsonEncode(params));
    try {
      Response response =
          await _dio.post(mainUrl + authUrl, data: jsonEncode(params));
      print(response.data);
      var data = response.data;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        prefs.setString("login", login);
        prefs.setString("password", password);
        prefs.setString("authToken", data["user"]["token"]["value"]);
        prefs.setString("userData", jsonEncode(data["user"]));
        //print(response.data);
        return UserResponseLoggedIn(data["user"]);
      } else {
        print("Неверный логин или пароль");
        return UserResponseLoggetOut("Неверный логин или пароль");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponseLoggetOut("Неверный логин или пароль");
    }
  }

  Future<UserResponse> userAuthLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String login = prefs.getString("login");
    String password = prefs.getString("password");
    String authToken = prefs.getString("authToken");
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    if (login != null &&
        password != null &&
        dataSP != null &&
        authToken != null) {
      var params = {"login": "$login", "password": "$password"};
      try {
        Response response = await _dio.post(mainUrl + authUrl, data: params);
        var data = response.data;
        if (response.statusCode >= 200 && response.statusCode < 300) {
          prefs.setString("authToken", data["user"]["token"]["value"]);
          prefs.setString("userData", jsonEncode(data["user"]));
          return UserResponseLoggedIn(data["user"]);
        } else {
          print("Авторизуйтесь");
          return UserResponseLoggetOut("Авторизуйтесь");
        }
      } catch (error) {
        //print("Exception occured: $error stackTrace: $stacktrace");
        return UserResponseLoggedIn(dataSP);
      }
    } else {
      return UserResponseLoggetOut("Авторизуйтесь");
    }
  }

  Future<UserResponse> userLogOut(int semestrNum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 1; i < semestrNum; i++) {
      prefs.remove("brs$i");
    }
    prefs.remove("login");
    prefs.remove("password");
    prefs.remove("authToken");
    prefs.remove("userData");
    prefs.remove("examssData");
    prefs.remove("lessonsData");
    prefs.remove("semestr");
    prefs.remove("currWeek");
    prefs.remove("group");
    prefs.remove("userTheme");
    return UserResponseLoggetOut("Авторизуйтесь");
  }

  Future<NewsResponse> getNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("authToken");
    var headers = {"Authorization": "Bearer $authToken"};
    if (authToken != null) {
      try {
        Response response = await _dio.get(mainUrl + newsUrl,
            options: Options(
              headers: headers,
            ));
        //var data = jsonDecode(response.data);

        var rest = response.data as List;
        //print(rest);
        if (rest.isNotEmpty) {
          return NewsResponse.fromJson(response.data);
        } else {
          return NewsResponse.withError("Нет новостей");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return NewsResponse.withError("Нет сети");
      }
    } else {
      return NewsResponse.withError("Авторизуйтесь");
    }
  }

  Future<ReportsResponse> getReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("authToken");
    var headers = {"Authorization": "Bearer $authToken"};
    if (authToken != null) {
      try {
        Response response = await _dio.get(mainUrl + reportsUrl,
            options: Options(
              headers: headers,
            ));
        //var data = jsonDecode(response.data);

        var rest = response.data as List;
        print(rest);
        if (rest.isNotEmpty) {
          return ReportsResponse.fromJson(response.data);
        } else {
          return ReportsResponse.withError("Нет заявок");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return ReportsResponse.withError("Нет сети");
      }
    } else {
      return ReportsResponse.withError("Авторизуйтесь");
    }
  }

  Future<ActivitysResponse> getActivitys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("authToken");
    var headers = {"Authorization": "Bearer $authToken"};
    print("/n$authToken");
    if (authToken != null) {
      try {
        Response response = await _dio.get(mainUrl + activitiesUrl,
            options: Options(
              headers: headers,
            ));
        //var data = jsonDecode(response.data);

        var rest = response.data as List;
        print(response);
        //print(response.data[0]['image']);
        if (rest.isNotEmpty) {
          return ActivitysResponse.fromJson(response.data);
        } else {
          return ActivitysResponse.withError("Нет Активностей");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return ActivitysResponse.withError("Нет сети");
      }
    } else {
      return ActivitysResponse.withError("Авторизуйтесь");
    }
  }

  Future<ReportResponse> sendReport(File file, String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("authToken");
    var headers = {"Authorization": "Bearer $authToken"};
    if (authToken != null) {
      if (text.isNotEmpty && file != null) {
        try {
          String fileName = file.path.split('/').last;
          FormData formData = FormData.fromMap({
            "message": "$text",
            "image":
                await MultipartFile.fromFile(file.path, filename: fileName),
          });
          Response response = await _dio.post(mainUrl + sendReportUrl,
              data: formData,
              options: Options(
                headers: headers,
              ));
          print(response);
          if (response.statusCode >= 200 && response.statusCode <= 299) {
            print("Ваша заявка принята");
            return ReportResponse.responseText("Ваша заявка принята");
          } else if ((response.statusCode >= 500)) {
            return ReportResponse.responseText("Ошибка сервера");
          } else {
            return ReportResponse.responseText("Ошибка ");
          }
        } catch (error, stacktrace) {
          print("Exception occured: $error stackTrace: $stacktrace");
          return ReportResponse.responseText("Не удалось отправить запрос");
        }
      } else {
        return ReportResponse.responseText("Заполните все поля");
      }
    } else {
      return ReportResponse.responseText("Авторизуйтесь");
    }
  }

  Future<int> getCurrWeek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("authToken");
    int currWeek = prefs.getInt("currWeek");
    var headers = {"Authorization": "Bearer $authToken"};
    if (authToken != null) {
      try {
        Response response = await _dio.get(mainUrl + getDateUrl,
            options: Options(
              headers: headers,
            ));
        print(response.data["eod"]);
        prefs.setInt("currWeek", response.data["eod"]);
        return (response.data["eod"]);
      } catch (error) {
        if (currWeek != null) {
          return currWeek;
        }
        return 0;
      }
    } else {
      return 0;
    }
  }
}

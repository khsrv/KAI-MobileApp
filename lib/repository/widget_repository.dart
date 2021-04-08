

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kai_mobile_app/model/weather_response.dart';
const apiKeyWeather = '2e443cf7753349b195378473e6668eaf';
const cityName = 'Kazan';
class WidgetRepository {
  static String weatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKeyWeather&units=metric";
  final Dio _dio = Dio();

  Future<WeatherResponse> getWeather() async {
    try {
      Response response = await _dio.post(weatherUrl);
      var data = response.data;
      print(data);
      var rest = data["weather"] as List;
      if (rest.isNotEmpty) {
        print(jsonEncode(data));
        return WeatherResponse.fromJson(data);
      } else {
        return WeatherResponse.withError("Нет данных");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return WeatherResponse.withError("Нет сети");
    }
  }
}
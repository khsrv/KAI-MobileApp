import 'package:kai_mobile_app/model/weather_model.dart';

class WeatherResponse {
  final WeatherModel weatherModel;
  final String error;

  WeatherResponse(this.weatherModel, this.error);

  WeatherResponse.fromJson(var data)
      : weatherModel = WeatherModel.fromJson(data),
        error = "";

  WeatherResponse.withError(String errorValue)
      : weatherModel = WeatherModel(),
        error = errorValue;
}

import 'package:kai_mobile_app/model/weather_response.dart';
import 'package:kai_mobile_app/repository/widget_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetWeatherBloc {
  final WidgetRepository _repository = WidgetRepository();
  final BehaviorSubject<WeatherResponse> _subject =
  BehaviorSubject<WeatherResponse>();

  getWeather() async {
    WeatherResponse response = await _repository.getWeather();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<WeatherResponse> get subject => _subject;

}
final getWeatherBloc = GetWeatherBloc();
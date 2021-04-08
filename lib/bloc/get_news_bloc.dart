import 'package:kai_mobile_app/model/news_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetNewsBloc {
  final MobileRepository _repository = MobileRepository();
  final BehaviorSubject<NewsResponse> _subject =
  BehaviorSubject<NewsResponse>();

  getNews() async {
    NewsResponse response = await _repository.getNews();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<NewsResponse> get subject => _subject;

}
final getNewsBloc = GetNewsBloc();
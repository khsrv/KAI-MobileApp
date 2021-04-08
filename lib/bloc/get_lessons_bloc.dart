import 'package:kai_mobile_app/model/lessons_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetLessonsBloc {
  final KaiRepository _repository = KaiRepository();
  final BehaviorSubject<LessonsResponse> _subject =
  BehaviorSubject<LessonsResponse>();

  getLessons() async {
    LessonsResponse response = await _repository.getLessons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<LessonsResponse> get subject => _subject;

}
final getLessonsBloc = GetLessonsBloc();
import 'package:kai_mobile_app/model/activitys_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetActivitysBloc {
  final MobileRepository _repository = MobileRepository();
  final BehaviorSubject<ActivitysResponse> _subject =
  BehaviorSubject<ActivitysResponse>();

  getActivitys() async {
    ActivitysResponse response = await _repository.getActivitys();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ActivitysResponse> get subject => _subject;

}
final getActivitysBloc = GetActivitysBloc();
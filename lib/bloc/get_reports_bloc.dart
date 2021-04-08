import 'package:kai_mobile_app/model/reports_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetReportsBloc {
  final MobileRepository _repository = MobileRepository();
  final BehaviorSubject<ReportsResponse> _subject =
  BehaviorSubject<ReportsResponse>();

  getReports() async {
    ReportsResponse response = await _repository.getReports();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ReportsResponse> get subject => _subject;

}
final getReportsBloc = GetReportsBloc();
import 'dart:io';

import 'package:kai_mobile_app/model/report_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:rxdart/rxdart.dart';

class SendReportBloc{
  final MobileRepository _repository = MobileRepository();
  final BehaviorSubject<ReportResponse> _subject =
      BehaviorSubject<ReportResponse>();

  sendReport(File img, String text) async{
    _subject.sink.add(ReportResponse.responseText("Loading"));
    ReportResponse response = await _repository.sendReport(img, text);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ReportResponse> get subject => _subject;

}
final sendReportBloc = SendReportBloc();
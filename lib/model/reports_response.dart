import 'package:kai_mobile_app/model/reports_model.dart';

class ReportsResponse {
  final List<ReportsModel> reports;
  final String error;

  ReportsResponse(this.reports, this.error);

  ReportsResponse.fromJson(List<dynamic> json)
      : reports =
  (json).map((i) => new ReportsModel.fromJson(i)).toList(),
        error = "";

  ReportsResponse.withError(String errorValue)
      : reports = List(),
        error = errorValue;
}
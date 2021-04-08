import 'package:kai_mobile_app/model/activity_model.dart';

class ActivitysResponse {
  final List<ActivityModel> news;
  final String error;

  ActivitysResponse(this.news, this.error);

  ActivitysResponse.fromJson(List<dynamic> json)
      : news =
  (json).map((i) => new ActivityModel.fromJson(i)).toList(),
        error = "";

  ActivitysResponse.withError(String errorValue)
      : news = List(),
        error = errorValue;
}
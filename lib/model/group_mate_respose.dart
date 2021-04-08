
import 'package:kai_mobile_app/model/group_mate_model.dart';

class GroupMateResponse {
  final List<GroupMateModel> group;
  final String error;

  GroupMateResponse(this.group, this.error);

  GroupMateResponse.fromJson(Map<String, dynamic> json)
      : group =
  (json["Data"] as List).map((i) => new GroupMateModel.fromJson(i)).toList(),
        error = "";

  GroupMateResponse.withError(String errorValue)
      : group = List(),
        error = errorValue;
}
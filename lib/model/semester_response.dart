import 'package:kai_mobile_app/model/semester_brs_model.dart';

class SemesterResponse {
  List<SemestrModel> semesters;
  String error;

  SemesterResponse(this.semesters, this.error);

  SemesterResponse.withError(String errorValue)
      : this.semesters = List(),
        this.error = errorValue;

  SemesterResponse.fromJson(var data) {
    this.semesters = List();
    for (int i = 1; i <= SemestrModel.fromJson(data).semesterNum; i++) {
      this.semesters.add(SemestrModel.withNum(i));
    }
    this.error = "";
  }
}

class SemesterResponseUserUnLogged extends SemesterResponse {
  SemesterResponseUserUnLogged() : super.withError("Авторизуйтесь");
}

class SemesterResponseUserLoggedIn extends SemesterResponse {
  SemesterResponseUserLoggedIn(var data) : super.fromJson(data);
}

class SemesterResponseWithError extends SemesterResponse {
  SemesterResponseWithError(String str) : super.withError(str);
}

class SemesterResponseLoading extends SemesterResponse {
  SemesterResponseLoading(String str) : super.withError(str);
}

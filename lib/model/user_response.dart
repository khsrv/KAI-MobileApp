import 'package:kai_mobile_app/model/user_model.dart';

class UserResponse {
  final UserModel user;
  String error = "";

  //UserResponse(this.user, this.error);
  UserResponse(this.user);

  UserResponse.fromJson(var data)
      : user = UserModel.fromJson(data),
        error = "";

  UserResponse.withError(String errorValue)
      : user = UserModel(),
        error = errorValue;
}

class UserResponseLoggedIn extends UserResponse {
  UserResponseLoggedIn(var data) : super.fromJson(data);
}

class UserResponseLoggetOut extends UserResponse {
  UserResponseLoggetOut(String errorValue) : super.withError(errorValue);
}

class UserResponseWithErrors extends UserResponse {
  UserResponseWithErrors(String errorValue) : super.withError(errorValue);
}

class UserResponseLoading extends UserResponse {
  UserResponseLoading() : super.withError("Загрузка");
}

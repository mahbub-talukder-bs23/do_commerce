import 'package:do_commerce/src/core/constants/constants.dart';
import 'package:do_commerce/src/domain/entity/login_entity.dart';

class LoginRequestModel extends LoginEntity {
  LoginRequestModel({required super.userName, required super.password});

  Map<String, dynamic> toJson() {
    return {'username': userName, 'password': password};
  }
}

class LoginResponseModel {
  final String accessToken;
  final String refreshToken;

  LoginResponseModel({required this.accessToken, required this.refreshToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json[StringConstants.accessTokenKey],
      refreshToken: json[StringConstants.refreshTokenKey],
    );
  }
}

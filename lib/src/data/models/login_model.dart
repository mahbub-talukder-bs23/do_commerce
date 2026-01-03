import 'package:do_commerce/src/domain/entity/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({required super.email, required super.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

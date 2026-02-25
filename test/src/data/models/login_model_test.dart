import 'package:flutter_test/flutter_test.dart';
import 'package:do_commerce/src/data/models/login_model.dart';
import 'package:do_commerce/src/core/constants/constants.dart';

void main() {
  group('LoginRequestModel', () {
    test('toJson should return correct map', () {
      final model = LoginRequestModel(
        userName: 'testuser',
        password: 'password123',
      );
      final result = model.toJson();

      expect(result, {'username': 'testuser', 'password': 'password123'});
    });
  });

  group('LoginResponseModel', () {
    test('fromJson should return valid model', () {
      final json = {
        StringConstants.accessTokenKey: 'access_token',
        StringConstants.refreshTokenKey: 'refresh_token',
      };

      final model = LoginResponseModel.fromJson(json);

      expect(model.accessToken, 'access_token');
      expect(model.refreshToken, 'refresh_token');
    });
  });
}

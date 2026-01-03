import 'package:do_commerce/src/data/services/local/secure_storage.dart';

import '../models/login_model.dart';
import '../services/network/api_end_points.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../services/network/rest_client/rest_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<String> login(LoginEntity loginEntity) async {
    try {
      final response = await restClient.post(
        ApiEndPoints.login,
        data: LoginModel(
          email: loginEntity.email,
          password: loginEntity.password,
        ).toJson(),
      );

      await SecureStorage().write(
        key: 'access_token',
        value: response.data['access_token'],
      );

      await SecureStorage().write(
        key: 'refresh_token',
        value: response.data['refresh_token'],
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

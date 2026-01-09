import '../../core/constants/constants.dart';
import '../../core/logger/logger.dart';
import '../services/local/secure_storage.dart';
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
        data: LoginRequestModel(
          userName: loginEntity.userName,
          password: loginEntity.password,
        ).toJson(),
      );

      final loginResponseModel = LoginResponseModel.fromJson(response.data);

      // await SecureStorage().write(
      //   key: StringConstants.accessTokenKey,
      //   value: loginResponseModel.accessToken,
      // );

      // await SecureStorage().write(
      //   key: StringConstants.refreshTokenKey,
      //   value: loginResponseModel.refreshToken,
      // );

      return 'Login Success';
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

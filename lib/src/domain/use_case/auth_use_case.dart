import '../repository/auth_repository.dart';

import '../entity/login_entity.dart';

class LoginUseCase {
  LoginUseCase({required this.authRepository});
  final AuthRepository authRepository;

  Future<String> call({
    required String userName,
    required String password,
  }) async {
    try {
      final loginEntity = LoginEntity(userName: userName, password: password);

      final res = await authRepository.login(loginEntity);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}

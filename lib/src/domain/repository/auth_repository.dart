import 'package:do_commerce/src/domain/entity/login_entity.dart';

abstract class AuthRepository {
  Future<String> login(LoginEntity loginEntity);
}

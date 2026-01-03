import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/auth_repository_impl.dart';
import '../../data/services/network/rest_client/rest_client.dart';
import '../../data/services/network/rest_client/rest_client_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/use_case/auth_use_case.dart';

part 'di.g.dart';

//use cases
@riverpod
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(authRepository: ref.read(authRepositoryProvider));
}

//repository
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(restClient: ref.read(restClientProvider));
}

//data source
@riverpod
RestClient restClient(Ref ref) {
  return RestClientImpl();
}

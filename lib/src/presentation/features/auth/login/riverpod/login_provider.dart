import 'dart:async';

import 'package:do_commerce/src/core/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      final res = await ref
          .read(loginUseCaseProvider)
          .call(userName: userName, password: password);

      state = AsyncData(res);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

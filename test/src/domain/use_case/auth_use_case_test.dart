import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:do_commerce/src/domain/use_case/auth_use_case.dart';
import 'package:do_commerce/src/domain/entity/login_entity.dart';

import '../../../mocks.mocks.dart';

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(authRepository: mockAuthRepository);
  });

  group('LoginUseCase', () {
    const userName = 'testuser';
    const password = 'password123';
    const token = 'fake_token';

    test('should call repository login and return token', () async {
      // Setup
      when(mockAuthRepository.login(any)).thenAnswer((_) async => token);

      // Execute
      final result = await useCase.call(userName: userName, password: password);

      // Verify
      expect(result, token);
      verify(
        mockAuthRepository.login(
          argThat(
            isA<LoginEntity>()
                .having((e) => e.userName, 'userName', userName)
                .having((e) => e.password, 'password', password),
          ),
        ),
      ).called(1);
    });

    test('should rethrow error if repository fails', () async {
      // Setup
      when(mockAuthRepository.login(any)).thenThrow(Exception('Login failed'));

      // Execute & Verify
      expect(
        () => useCase.call(userName: userName, password: password),
        throwsA(isA<Exception>()),
      );
    });
  });
}

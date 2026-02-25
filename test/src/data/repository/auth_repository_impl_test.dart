import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:do_commerce/src/data/repository/auth_repository_impl.dart';
import 'package:do_commerce/src/domain/entity/login_entity.dart';
import 'package:do_commerce/src/core/constants/constants.dart';
import 'package:do_commerce/src/data/services/network/api_end_points.dart';

import '../../../mocks.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockRestClient mockRestClient;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockRestClient = MockRestClient();
    mockSecureStorage = MockSecureStorage();
    repository = AuthRepositoryImpl(
      restClient: mockRestClient,
      secureStorage: mockSecureStorage,
    );
  });

  group('AuthRepositoryImpl.login', () {
    final loginEntity = LoginEntity(userName: 'user', password: 'password');
    final loginResponseData = {
      StringConstants.accessTokenKey: 'access_token_123',
      StringConstants.refreshTokenKey: 'refresh_token_456',
    };

    test(
      'should return "Login Success" and save tokens when API call is successful (AAA Pattern)',
      () async {
        // Arrange
        final response = Response(
          data: loginResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiEndPoints.login),
        );

        when(
          mockRestClient.post(any, data: anyNamed('data')),
        ).thenAnswer((_) async => response);

        when(
          mockSecureStorage.write(
            key: anyNamed('key'),
            value: anyNamed('value'),
          ),
        ).thenAnswer((_) async => {});

        // Act
        final result = await repository.login(loginEntity);

        // Assert
        expect(result, 'Login Success');

        // Verify API call
        verify(
          mockRestClient.post(
            ApiEndPoints.login,
            data: {
              'username': loginEntity.userName,
              'password': loginEntity.password,
            },
          ),
        ).called(1);

        // Verify SecureStorage calls
        verify(
          mockSecureStorage.write(
            key: StringConstants.accessTokenKey,
            value: 'access_token_123',
          ),
        ).called(1);

        verify(
          mockSecureStorage.write(
            key: StringConstants.refreshTokenKey,
            value: 'refresh_token_456',
          ),
        ).called(1);
      },
    );

    test('should throw Exception when API call fails', () async {
      // Arrange
      when(mockRestClient.post(any, data: anyNamed('data'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiEndPoints.login),
          error: 'Unauthorized',
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      expect(() => repository.login(loginEntity), throwsA(isA<Exception>()));
    });

    test('should throw Exception when SecureStorage fails to write', () async {
      // Arrange
      final response = Response(
        data: loginResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiEndPoints.login),
      );

      when(
        mockRestClient.post(any, data: anyNamed('data')),
      ).thenAnswer((_) async => response);

      when(
        mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')),
      ).thenThrow(Exception('Storage full'));

      // Act & Assert
      expect(() => repository.login(loginEntity), throwsA(isA<Exception>()));
    });

    test('should throw Exception when API returns malformed JSON', () async {
      // Arrange
      final response = Response(
        data: {'wrong_key': 'no_token'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiEndPoints.login),
      );

      when(
        mockRestClient.post(any, data: anyNamed('data')),
      ).thenAnswer((_) async => response);

      // Act & Assert
      expect(() => repository.login(loginEntity), throwsA(isA<Exception>()));
    });
  });
}

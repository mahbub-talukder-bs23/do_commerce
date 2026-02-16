import 'package:do_commerce/src/data/repository/product_details_repository_imp.dart';
import 'package:do_commerce/src/data/repository/product_list_repository_impl.dart';
import 'package:do_commerce/src/domain/repository/product_details_repository.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';
import 'package:do_commerce/src/domain/use_case/product_details_use_case.dart';
import 'package:do_commerce/src/domain/use_case/product_list_use_case.dart';
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

@riverpod
ProductListUseCase productListUseCase(Ref ref) {
  return ProductListUseCase(
    productListRepository: ref.read(productListRepositoryProvider),
  );
}

@riverpod
ProductDetailsUseCase productDetailsUseCase(Ref ref) {
  return ProductDetailsUseCase(
    productDetailsRepository: ref.read(productDetailsRepositoryProvider),
  );
}

//repository
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(restClient: ref.read(restClientProvider));
}

@Riverpod(keepAlive: true)
ProductListRepository productListRepository(Ref ref) {
  return ProductListRepositoryImpl(restClient: ref.read(restClientProvider));
}

@Riverpod(keepAlive: true)
ProductDetailsRepository productDetailsRepository(Ref ref) {
  return ProductDetailsRepositoryImp(restClient: ref.read(restClientProvider));
}

//data source
@riverpod
RestClient restClient(Ref ref) {
  return RestClientImpl();
}

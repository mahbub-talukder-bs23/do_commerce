import 'package:do_commerce/src/core/pagination/pagination_strategies.dart';
import 'package:do_commerce/src/data/services/local/secure_storage.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:do_commerce/src/domain/repository/auth_repository.dart';
import 'package:do_commerce/src/domain/repository/product_details_repository.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';
import 'package:do_commerce/src/domain/use_case/auth_use_case.dart';
import 'package:do_commerce/src/domain/use_case/product_details_use_case.dart';
import 'package:do_commerce/src/domain/use_case/product_list_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  RestClient,
  PaginationStrategy,
  AuthRepository,
  ProductListRepository,
  ProductDetailsRepository,
  LoginUseCase,
  ProductListUseCase,
  ProductDetailsUseCase,
  SecureStorage,
])
void main() {}

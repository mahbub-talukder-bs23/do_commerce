// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:riverpod_practice/async_value/service/data_handler.dart';

// part 'get_data_provider.g.dart';

// @riverpod
// class GetData extends _$GetData {
//   @override
//   FutureOr<String?> build() {
//     getData();
//     return null;
//   }

//   void getData() async {
//     state = const AsyncLoading();

//     try {
//       final dataProvider = await DataHandler().getData();
//       final data = dataProvider;
//       state = AsyncData(data);
//     } catch (e) {
//       state = AsyncError(e, StackTrace.current);
//     }
//   }
// }
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'get_data_provider.g.dart';

// @riverpod
// class GetData extends _$GetData {
//   @override
//   Future<String> build() async {
//     return await DataProvider().getData();
//   }
// }

// class DataProvider {
//   Future<String> getData() async {
//     await Future.delayed(const Duration(seconds: 2));
//     return 'Flutter Riverpod Async Value';
//     // throw Exception('Failed to fetch data');
//   }
// }

import 'package:basics_samples/sources/firebase_functions_source.dart';
import 'package:basics_samples/sources/auth_source.dart';
import 'package:basics_samples/sources/firestore_source.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

abstract class DependencyInjection {
  static Future<void> init() async {
    sl.registerLazySingleton<FirebaseFunctionsSource>(
      () => FirebaseFunctionsSource(),
    );
    sl.registerLazySingleton<FirestoreSource>(
      () => FirestoreSource(),
    );
    sl.registerLazySingleton<AuthSource>(
      () => AuthSource(
        firebaseFunctionsSource: sl<FirebaseFunctionsSource>(),
      ),
    );
  }
}

import 'package:authentication_app/authentication/data/repository/auth_remote_repository.dart';
import 'package:authentication_app/core/di/app_injection_container.dart';

void init() {
  /// Repositories
  sl.registerFactory<AuthRemoteRepository>(
      () => AuthRemoteRepositoryImpl(sl()));
}

import 'package:authentication_app/authentication/data/network/data_sources/auth_remote_data_source.dart';
import 'package:authentication_app/core/di/app_injection_container.dart';

void init() {
  sl.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
}

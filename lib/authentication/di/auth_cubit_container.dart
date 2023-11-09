import 'package:authentication_app/authentication/feature/login/cubit/cubit/login_cubit.dart';
import 'package:authentication_app/core/di/app_injection_container.dart';

void init() {
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
}

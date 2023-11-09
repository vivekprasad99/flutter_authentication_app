import 'package:authentication_app/authentication/data/model/user_model.dart';
import 'package:authentication_app/authentication/data/network/data_sources/auth_remote_data_source.dart';
import 'package:authentication_app/core/exception/exception.dart';
import 'package:authentication_app/core/utils/app_log.dart';

abstract class AuthRemoteRepository {
  Future<UserModel> signInByUserName(String userName, String password);
}

class AuthRemoteRepositoryImpl implements AuthRemoteRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRemoteRepositoryImpl(this._dataSource);

  @override
  Future<UserModel> signInByUserName(String userName, String password) async {
    try {
      final apiResponse =
          await _dataSource.signInByUserName(userName, password);
      if (apiResponse.statusCode == 200) {
        return UserModel.fromJson(apiResponse.data as Map<String, dynamic>);
      } else {
        throw FailureException(0, apiResponse.statusMessage);
      }
    } catch (e, stacktrace) {
      AppLog.e('signInByUserName : ${e.toString()} \n${stacktrace.toString()}');
      rethrow;
    }
  }
}

import 'package:authentication_app/authentication/data/network/api/auth_api.dart';
import 'package:authentication_app/core/data/remote/rest_client.dart';
import 'package:authentication_app/core/utils/constants.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Response> signInByUserName(String userName, String password);
}

class AuthRemoteDataSourceImpl extends AuthAPI implements AuthRemoteDataSource {
  @override
  Future<Response> signInByUserName(String userName, String password) async {
    try {
      Map<String, String> body = {
        Constants.username: userName,
        Constants.password: password
      };
      Response response = await logintRestClient.post(authAPI, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

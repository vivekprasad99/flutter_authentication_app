import 'package:dio/dio.dart';

class ServerException implements Exception {
  int? code;
  String? message;
  dynamic data;

  ServerException(this.code, this.message);

  ServerException.fromErrorDioError(DioError e) {
    if (e.response != null && e.response?.data != null) {
      Map<String, dynamic> json = e.response?.data as Map<String, dynamic>;
      String errorMessage = json['message'] ?? e.response?.statusMessage ?? '';
      code = e.response?.statusCode;
      message = errorMessage;
      data = json['data'];
    } else {
      code = 0;
      message = 'There is some Technical error. please try again';
    }
  }

  @override
  String toString() {
    return 'Error occurred. Code: $code';
  }
}

class FailureException implements Exception {
  final int? code;
  final String? message;

  FailureException(this.code, this.message);

  @override
  String toString() {
    return 'Error occurred. Code: $code';
  }
}

class PlayerServiceNotRunningException implements Exception {}

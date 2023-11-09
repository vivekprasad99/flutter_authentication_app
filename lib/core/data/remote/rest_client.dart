import 'package:authentication_app/core/data/header/header_utils.dart';
import 'package:authentication_app/core/exception/exception.dart';
import 'package:authentication_app/core/utils/app_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RestClient {
  late Dio _dio;

  RestClient(String baseURL) {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: Duration(minutes: 3),
    );
    options.headers.remove(Headers.contentLengthHeader);
    _dio = Dio(options);
    if (kDebugMode) {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  Future<Response> get(apiName,
      {body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? header,
      Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "get");
      option.headers = headers;
    }

    try {
      Response response = await _dio.request(apiName,
          queryParameters: queryParams, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioException) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(
            0, 'There is some Technical error. please try again');
      }
    }
  }

  Future<Response> post(apiName,
      {body, Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "post");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(
            0, 'There is some Technical error. please try again');
      }
    }
  }

  Future<Response> patch(apiName,
      {body, Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "patch");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(
            0, 'There is some Technical error. please try again');
      }
    }
  }

  Future<Response> put(apiName,
      {body, Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "put");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(
            0, 'There is some Technical error. please try again');
      }
    }
  }

  Future<Response> delete(apiName,
      {body, Map<String, dynamic>? header, Options? option}) async {
    Map<String, dynamic> headers = await HeadersUtils.getHeaders();

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "delete");
      option.headers = headers;
    }

    try {
      Response response =
          await _dio.request(apiName, data: body, options: option);

      if (response.statusCode! < 200 || response.statusCode! > 400) {
        throw ServerException(response.statusCode, response.statusMessage);
      }
      return response;
    } catch (e) {
      if (e is DioError) {
        AppLog.e(e.response.toString());

        if (e.response != null && e.response?.statusCode == 401) {
          checkExceptionAndDoLogout(e);
        }

        throw ServerException.fromErrorDioError(e);
      } else {
        throw ServerException(
            0, 'There is some Technical error. please try again');
      }
    }
  }

  void checkExceptionAndDoLogout(DioError e) {
    if (e.response != null && e.response?.data != null) {
      Map<String, dynamic> json = e.response?.data as Map<String, dynamic>;
      if (json['reason'] == 'invalid token or token expired') {
        //  Logout code
      }
    }
  }
}

late RestClient logintRestClient;

void init(String baseURL) {
  initLoginRestClient(baseURL);
}

void initLoginRestClient(String baseURL) {
  logintRestClient = RestClient(baseURL);
}

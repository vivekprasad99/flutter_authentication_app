import 'dart:collection';
import 'package:authentication_app/core/utils/app_log.dart';

class HeadersUtils {
  static const contentType = 'Content-Type';

  static Future<Map<String, dynamic>> getHeaders() async {
    Map<String, dynamic> headers = HashMap();
    try {
      headers.putIfAbsent(contentType, () => 'application/json');
    } catch (e, stacktrace) {
      AppLog.e('getHeaders : ${e.toString()} \n${stacktrace.toString()}');
    }
    return headers;
  }
}

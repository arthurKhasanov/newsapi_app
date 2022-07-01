import 'package:dio/dio.dart';

class ServerUtil {
  ServerUtil();

  // const url
  static const String baseUrl = 'https://newsapi.org/v2/everything?';

  late Dio api;

  void init() {
    api = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    api.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
}

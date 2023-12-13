import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;
  DioClient._(this._dio);
  factory DioClient.create(Dio dio, {List<Interceptor>? interceptors}) {
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
    return DioClient._(dio);
  }
  String get baseUrl => _dio.options.baseUrl;
  Dio get dio => _dio;
}

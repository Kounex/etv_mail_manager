import 'package:dio/dio.dart';

abstract class DioClient {
  static final instance = Dio(
    BaseOptions(
      baseUrl: '',
    ),
  );
}

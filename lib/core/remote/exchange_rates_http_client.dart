import 'dart:io';

import 'package:dio/dio.dart';

class ExchangeRatesHttpClient {
  ExchangeRatesHttpClient._(this.dio);

  factory ExchangeRatesHttpClient.singleton() {
    return ExchangeRatesHttpClient._(_dioInstance);
  }

  final Dio dio;

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://www.nbrb.by/api/',
  ));
  static Dio get _dioInstance {
    return _dio;
  }
}

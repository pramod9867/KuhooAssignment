import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:kuhoodemo/utils/constants/appconstants.dart';

class ApiClient {
  Dio? dioClient;

  ApiClient.defaultClient({BaseOptions? baseOptions}) {
    if (baseOptions == null) {
      baseOptions = BaseOptions(
          baseUrl: AppConstants.network.getBaseUrl(),
          connectTimeout: 120000,
          receiveTimeout: 120000,
          headers: {
            "platform": "Android",
            "Content-Type": "application/json;charset=UTF-8",
            "Charset": "utf-8",
          });
    }

    dioClient = Dio(baseOptions);

    dioClient!.interceptors.add(LogInterceptor());

    (dioClient?.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (HttpClient? client) {
      client!.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;

      return client;
    };
  }
}

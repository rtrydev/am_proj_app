import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class RetrofitApi {
  static Dio dio = Dio();
  static final RetrofitApi _retrofitApi = RetrofitApi._internal();

  factory RetrofitApi() {
    return _retrofitApi;
  }

  Future<Dio> getApiClient() async {
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          SharedPreferences
              .getInstance()
              .then((prefs) {
            var token = prefs.getString('token');

            if (token != null && token != '') {
              request.headers['Authorization'] = 'Bearer $token';
            }
          });

          return handler.next(request);
        },

        onResponse: (response, handler) {
          return handler.next(response);
        },

        onError: (error, handler) {
          if (error.response?.statusCode != 401) {
            return;
          }

          SharedPreferences
            .getInstance()
            .then((prefs) => prefs.setString('token', ''));
        }
      )
    );

    return dio;
  }

  RetrofitApi._internal();
}
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task5/data/apiweather.dart';
import 'package:task5/data/data.dart';
import 'package:task5/data/my_data.dart';

class DemoApi {
  late Dio _dio;

  DemoApi() {
    _dio = Dio(BaseOptions(baseUrl: base_url));
    _dio.interceptors.add(DioInterceptor());
  }

  Future<WeatherApi> getData() async {
    final response = await _dio.get(current + '?key=$API_KEY&q=berlin',
        options: Options(method: "GET"));
    if (response.statusCode == 200) {
     // print(json.encode(response.data));
      final weatherdata = response.data;
      final weatherMap = response.data as Map<String, dynamic>;
      final weatherApi = WeatherApi.fromJson(weatherMap);
      return weatherApi;

    } else {
      print(response.statusMessage);
      throw Exception('Failed to load weather data');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:task5/data/my_data.dart';

class DioInterceptor extends Interceptor {
  // Dio dio =Dio(BaseOptions(baseUrl: base_url));
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers.addAll({"Content-Type":"application/json",
    // "Authorization":"Bearer ${API_KEY}"});
    print("url: " +
        options.uri.toString() +
        options.contentType.toString() +'======'+
        options.responseType.toString() +'======'+
        options.connectTimeout.toString() +'======'+
        options.receiveTimeout.toString() +'======'+
        options.validateStatus.toString());
    return super.onRequest(options, handler);
  }

  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("respnse: " + response.toString());

    return super.onResponse(response, handler);
  }
}

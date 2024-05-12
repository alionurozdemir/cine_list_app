import 'dart:convert';
import 'dart:developer';

import 'package:cine_list_app/services/base_models.dart';
import 'package:cine_list_app/services/request_model.dart';
import 'package:cine_list_app/services/request_response_model.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';

class NetworkService {
  late final Dio _dio;
  NetworkService() {
    _dio = Dio(BaseOptions(
      receiveTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ));
    _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
  }

  Future<ResponseModel<T>> send<T, R>(RequestModel model) async {
    try {
      var baseUrl = "https://api.themoviedb.org${model.getEndPoint}";

      final response = await _dio.request<Map<String, dynamic>?>(baseUrl,
          queryParameters: model.queryParameters,
          data: model.body,
          options: Options(
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              ...{
                "Authorization":
                    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMzkwNjMzMDBlZmFlODZhYTg4ODAyMjc1OTg0NGMzYyIsInN1YiI6IjYyODNmMjJiZWM0NTUyMTAzMmFhNzFhMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.T3DuUKekGibamzwWGLI-zK57LfN6t8r_QeSbLx7zKhI"
              }
            },
            method: model.type!.name,
          ));
      log("Response: \n${jsonEncode(response.data)}");
      if (200 <= response.statusCode! && response.statusCode! <= 210) {
        return ResponseModel<T>(ResponseEnum.success,
            data: model.justDecode!
                ? response.data
                : response.data is List
                    ? (response.data as List)
                        .map<R>((e) => (model.parseModel as BaseModel).fromJson(e))
                        .toList()
                    : (model.parseModel as BaseModel).fromJson(response.data));
      } else {
        print(response.data.toString());
        return ResponseModel(ResponseEnum.info, error: response.data.toString());
      }
    } on DioException catch (e) {
      return ResponseModel(ResponseEnum.error, error: e.response?.data['message'].toString());
    } on Exception catch (e) {
      return ResponseModel(ResponseEnum.error, error: e.toString());
    }
  }
}

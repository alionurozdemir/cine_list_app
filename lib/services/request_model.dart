import 'package:dio/dio.dart';

class RequestModel<T> {
  final String endPoint;
  Map<String, dynamic>? body;
  Map<String, dynamic>? queryParameters;
  bool? isHeader;
  RequestTypes? type;
  bool? justDecode;
  T? parseModel;
  FormData? formData;
  Map<String, dynamic>? header;
  RequestModel(
      {required this.endPoint,
      this.body,
      this.type = RequestTypes.POST,
      this.queryParameters = const {},
      this.isHeader = true,
      this.justDecode = false,
      this.parseModel,
      this.formData,
      this.header = const {}});

  String get getEndPoint {
    String end = endPoint;
    if (endPoint.startsWith('/')) {
      end = endPoint.substring(1);
    }
    return "/$end";
  }
}

enum RequestTypes {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}

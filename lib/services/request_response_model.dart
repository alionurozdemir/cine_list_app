class ResponseModel<T> {
  final ResponseEnum status;
  T? data;
  String? error;

  ResponseModel(this.status, {this.data, this.error});
}

enum ResponseEnum { success, error, empty, info, unknown }

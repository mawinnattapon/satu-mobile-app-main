class RestApi {
  RestApi();

  late String status;
  late int code;
  late String message;
  late dynamic data;

  RestApi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['status'] = status;
    json['code'] = code;
    json['message'] = message;
    json['data'] = "$data";
    return json;
  }

  @override
  String toString() {
    return "{ status: $status, code: $code, message: $message, data: $data }";
  }
}

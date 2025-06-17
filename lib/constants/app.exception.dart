import 'package:satu/models/app/rest.api.model.dart';

class RestException implements Exception {
  final RestApi rest;

  RestException(this.rest);

  String get status => rest.status;
  int get code => rest.code;
  String get message => rest.message;
  dynamic get data => rest.data;

  @override
  String toString() {
    return rest.message;
  }
}

class AppException implements Exception {
  final String errorDesc;

  AppException(
    this.errorDesc,
  );

  String getMessage() {
    return errorDesc;
  }

  @override
  String toString() {
    return errorDesc;
  }
}

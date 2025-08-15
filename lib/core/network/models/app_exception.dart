import 'package:dio/dio.dart';

class AppException implements Exception {
  final int statusCode;
  final String message;
  final String identifier;

  AppException({
    required this.statusCode,
    required this.message,
    required this.identifier,
  });

  @override
  String toString() =>
      'statusCode=$statusCode\nmessage=$message\nidentifier=$identifier';
}

import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';

abstract class ApiConsumer {
  Future<Either<ServerFailure, Map<String, dynamic>>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Either<ServerFailure, Map<String, dynamic>>> post({
    required String path,
    required Object body,
    bool formDataEnabled = false,
    String? contentType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Either<ServerFailure, Map<String, dynamic>>> put({
    required String path,
    required Object body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Either<ServerFailure, Map<String, dynamic>>> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
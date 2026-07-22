import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/apis/api_consumer.dart';
import 'package:velora/core/network/errors/failure.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    
    client.options.baseUrl = "https://accessories-eshop.runasp.net/api"; 
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ServerFailure(msg: e.message ?? "Something went wrong"));
    }
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> post({
    required String path,
    required Object body,
    bool formDataEnabled = false,
    String? contentType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.post(
        path,
        data: formDataEnabled ? FormData.fromMap(body as Map<String, dynamic>) : body,
        queryParameters: queryParameters,
        options: Options(headers: headers, contentType: contentType),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ServerFailure(msg: e.message ?? "Something went wrong"));
    }
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> put({
    required String path,
    required Object body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ServerFailure(msg: e.message ?? "Something went wrong"));
    }
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ServerFailure(msg: e.message ?? "Something went wrong"));
    }
  }
}
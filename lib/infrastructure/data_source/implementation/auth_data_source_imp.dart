import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/api/api_consumer.dart';
import 'package:velora/core/network/api/endpoints.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/infrastructure/data_source/abstraction/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final ApiConsumer apiConsumer;

  AuthDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await apiConsumer.post(
        path: EndPoints.signUp,
        body: {
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
        },
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await apiConsumer.post(
        path: EndPoints.verifyEmail,
        body: {
          "email": email,
          "otp": otp, 
        },
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiConsumer.post(
        path: EndPoints.login,
        body: {
          "email": email,
          "password": password,
        },
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}
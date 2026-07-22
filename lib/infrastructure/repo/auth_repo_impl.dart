import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/domain/repos/auth_repo.dart';
import 'package:velora/infrastructure/data_source/auth_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl({required this.authDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await authDataSource.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await authDataSource.verifyEmail(
        email: email,
        otp: otp,
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authDataSource.login(
        email: email,
        password: password,
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
}
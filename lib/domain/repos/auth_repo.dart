import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, Map<String, dynamic>>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<Either<Failure, Map<String, dynamic>>> verifyEmail({
    required String email,
    required String otp,
  });

  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  });
}
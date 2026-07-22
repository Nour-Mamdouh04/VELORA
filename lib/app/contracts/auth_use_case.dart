import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/domain/repos/auth_repo.dart';

class AuthUseCase {
  final AuthRepo authRepo;

  AuthUseCase({required this.authRepo});

  Future<Either<Failure, Map<String, dynamic>>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await authRepo.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }

 
  Future<Either<Failure, Map<String, dynamic>>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    return await authRepo.verifyEmail(
      email: email,
      otp: otp,
    );
  }

 
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    return await authRepo.login(
      email: email,
      password: password,
    );
  }
}
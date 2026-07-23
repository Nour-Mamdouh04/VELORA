import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/app/contracts/auth_use_case.dart';
import 'package:velora/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;

  AuthCubit({required this.authUseCase}) : super(AuthInitial());

  
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(AuthLoading());
    final result = await authUseCase.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    result.fold(
      (failure) => emit(AuthFailure(message: failure.msg)),
      (data) => emit(SignUpSuccess(email: email)),
    );
  }

 
  Future<void> verifyEmail({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoading());
    final result = await authUseCase.verifyEmail(email: email, otp: otp);
    result.fold(
      (failure) => emit(AuthFailure(message: failure.msg)),
      (data) => emit(VerifyEmailSuccess()),
    );
  }


  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await authUseCase.login(email: email, password: password);
    result.fold(
      (failure) => emit(AuthFailure(message: failure.msg)),
      (data) {
        final token = data['token'] ?? data['accessToken'] ?? "";
        emit(LoginSuccess(token: token));
      },
    );
  }
}
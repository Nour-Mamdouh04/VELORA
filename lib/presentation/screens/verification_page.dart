import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:velora/injection_container.dart';
import 'package:velora/presentation/cubit/auth_cubit.dart';
import 'package:velora/presentation/cubit/auth_state.dart';
import 'package:velora/app/rounting/routes.dart';
import 'package:velora/core/widgets/custom_app_button.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key, required this.email});

  final String email;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 121, 113, 72),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: const Color.fromARGB(255, 121, 113, 72),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(15),
    );
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is VerifyEmailSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Email verified successfully!"),
                ),
              );
              context.pushReplacementNamed(Routes.login);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Text(
                        "Send Verification Code",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 121, 113, 72),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "An OTP has been sent to your email:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "DMSans",
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 50),
                      Pinput(
                        length: 4,
                        controller: pinController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        validator: (value) {
                          if (value == null || value.length < 4) {
                            return "Please enter the full 4-digit code.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 60),
                      state is AuthLoading
                          ? const CircularProgressIndicator()
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 80, 80, 80),
                                    Color.fromARGB(255, 132, 132, 131),
                                    Color.fromARGB(255, 1, 1, 0),
                                  ],
                                ),
                              ),
                           child: CustomAppButton(
                                title: 'Verify',
                                fontWeight: FontWeight.bold,
                                backgroundColor: const Color.fromARGB(224, 56, 56, 53),
                                textColor: Colors.white,
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                   
                                    context.read<AuthCubit>().verifyEmail(
                                          email: widget.email,
                                          otp: pinController.text,
                                        );
                                  }
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

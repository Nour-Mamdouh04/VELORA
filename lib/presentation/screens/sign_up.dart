import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:velora/core/utils/app_theme_cubit.dart';
import 'package:velora/core/utils/app_theme_state.dart';
import 'package:velora/core/widgets/custom_app_button.dart';
import 'package:velora/app/rounting/routes.dart';
import 'package:velora/injection_container.dart';
import 'package:velora/presentation/cubit/auth_cubit.dart';
import 'package:velora/presentation/cubit/auth_state.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<AppThemeCubit, AppThemeState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(state.isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    context.read<AppThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              context.pushNamed(
                Routes.verify,
                queryParameters: {"email": state.email},
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Up Account",
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "DMSans",
                        color: Color.fromARGB(255, 187, 171, 148),
                      ),
                    ),
                    Text(
                      "Find the fragrance that feels like you.",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "DMSans",
                        color: Color.fromARGB(255, 187, 171, 148),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your first name.";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                hintStyle: TextStyle(fontFamily: "DMSans"),
                                prefixIcon: Icon(Icons.person_outline),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 187, 171, 148),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 187, 171, 148),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your last name.";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                hintStyle: TextStyle(fontFamily: "DMSans"),
                                prefixIcon: Icon(Icons.person_outline),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 187, 171, 148),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 187, 171, 148),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email.";
                                }
                                if (!value.contains('@')) {
                                  return "Please enter a valid email.";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(fontFamily: "DMSans"),
                                prefixIcon: Icon(Icons.mail_outline),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 187, 171, 148),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 187, 171, 148),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (pass) {
                                if (pass == null ||
                                    pass.isEmpty ||
                                    pass.length < 8) {
                                  return "Please enter valid password (min 8 chars)";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your Password',
                                hintStyle: TextStyle(fontFamily: "DMSans"),
                                prefixIcon: Icon(Icons.lock_outline),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 187, 171, 148),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 187, 171, 148),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
                              title: 'Sign Up',
                              fontWeight: FontWeight.bold,
                              backgroundColor: const Color.fromARGB(
                                224,
                                56,
                                56,
                                53,
                              ),
                              textColor: Colors.white,
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Sending OTP ..."),
                                    ),
                                  );
                                  context.pushNamed(
                                    Routes.verify,
                                    queryParameters: {
                                      "email": emailController.text,
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "or",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontFamily: "DMSans",
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "lib/core/utils/assets/svg/icons8-google.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "lib/core/utils/assets/svg/icons8-apple.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "lib/core/utils/assets/svg/icons8-facebook.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontFamily: "DMSans",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(Routes.login);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 74, 74, 74),
                                fontFamily: "DMSans",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

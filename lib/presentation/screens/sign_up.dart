import 'package:flutter/material.dart';
import '../../core/widgets/custom_app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "../../app/rounting/routes.dart";
import 'package:go_router/go_router.dart';
import 'package:velora/core/utils/app_theme_cubit.dart';
import 'package:velora/core/utils/app_theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up Account",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "DMSans",
                  color: const Color.fromARGB(255, 187, 171, 148),
                ),
              ),
              Text(
                "Find the fragrance that feels like you.",
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "DMSans",
                  color: const Color.fromARGB(255, 187, 171, 148),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(fontFamily: "DMSans"),
                          prefixIcon: Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 187, 171, 148),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 187, 171, 148),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        validator: (pass) {
                          if (pass == null || pass.isEmpty || pass.length < 8) {
                            return "Please enter valid password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your Password',
                          hintStyle: TextStyle(fontFamily: "DMSans"),
                          prefixIcon: Icon(Icons.lock_outline),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 187, 171, 148),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 187, 171, 148),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (confirm) {
                          if (confirm == null ||
                              confirm.isEmpty ||
                              confirm.length < 8) {
                            return "Please enter valid password";
                          }
                          if (confirm != passwordController.text) {
                            return "Your Passwords don't match";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(fontFamily: "DMSans"),
                          prefixIcon: Icon(Icons.lock_outline),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 187, 171, 148),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 80, 80, 80), // Gold فاتح
                      Color.fromARGB(255, 132, 132, 131), // Gold
                      Color.fromARGB(255, 1, 1, 0),
                    ],
                  ),
                ),
                child: CustomAppButton(
                  title: 'Sign Up',
                  fontWeight: FontWeight.bold,
                  backgroundColor: const Color.fromARGB(224, 56, 56, 53),
                  textColor: Colors.white,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      print(emailController.text);
                      print(passwordController.text);
                      print(confirmPassword.text);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "or",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontFamily: "DMSans",
                        ),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
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
                        "assets/svg/icons8-google.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
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
                        "assets/svg/icons8-apple.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
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
                        "assets/svg/icons8-facebook.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 130.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
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
      ),
    );
  }
}

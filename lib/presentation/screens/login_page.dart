import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:velora/infrastructure/api/api_services.dart';
import 'package:velora/core/utils/app_theme_cubit.dart';
import 'package:velora/core/utils/app_theme_state.dart';
import '../../core/widgets/custom_app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/rounting/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(), home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final ApiServices apiservice = ApiServices();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "lib/core/utils/assets/images/img_2.jfif",
                        width: double.infinity,
                        height: 350,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.white,
                            ],
                            stops: const [0.0, 0.75, 1.0],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 270.0),
                        child: const Center(
                          child: Text(
                            'VELORA',
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 187, 171, 148),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
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
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your Password',
                              hintStyle: TextStyle(fontFamily: "DMSans"),
                              prefixIcon: Icon(Icons.lock_outline),
                              enabledBorder: OutlineInputBorder(
                                // borderSide: BorderSide(
                                //   color: Color.fromARGB(255, 187, 171, 148),
                                // ),
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
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      title: 'Login',
                      fontWeight: FontWeight.bold,
                      backgroundColor: const Color.fromARGB(224, 56, 56, 53),
                      textColor: Colors.white,
                      onPress: () {
                        if (_formkey.currentState!.validate()) {
                          context.pushNamed(
                            Routes.query,
                            queryParameters: {"email": emailController.text},
                          );
                          print(emailController.text);
                          print(passwordController.text);
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
                            "lib/core/utils/assets/svg/icons8-google.svg",
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
                            "lib/core/utils/assets/svg/icons8-apple.svg",
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
                            "lib/core/utils/assets/svg/icons8-facebook.svg",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: BlocBuilder<AppThemeCubit, AppThemeState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            context.read<AppThemeCubit>().toggleTheme();
                          },
                          icon: Icon(
                            state.isDark ? Icons.light_mode : Icons.dark_mode,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.signUp);
                          },
                          child: const Text(
                            "Sign Up",
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
      },
    );
  }
}

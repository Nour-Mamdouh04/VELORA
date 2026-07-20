import 'package:flutter/material.dart';
import 'package:velora/core/utils/app_theme_cubit.dart';
import 'package:velora/core/utils/app_theme_state.dart';
import 'app/rounting/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AppThemeCubit())],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: state.isDark
                ? ThemeData.dark()
                : ThemeData.light().copyWith(
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                  ),
            routerConfig: AppRouter.appRouter,
          );
        },
      ),
    );
  }
}

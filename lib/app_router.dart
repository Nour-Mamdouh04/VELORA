import 'package:go_router/go_router.dart';
import 'package:velora/api_services.dart';
import 'package:velora/home_cubit.dart';
import 'package:velora/login_page.dart';
import 'package:velora/product_details_screen.dart';
import 'package:velora/query_result.dart';
import 'package:velora/routes.dart';
import 'sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static final appRouter = GoRouter(
    initialLocation: "/",

    routes: [
      GoRoute(
        path: "/",
        name: Routes.login,
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: "/signUp",
        name: Routes.signUp,
        builder: (context, state) => const SignUp(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => HomeCubit(apiServices: ApiServices()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: "/query",
            name: Routes.query,
            builder: (context, state) {
              final email = state.uri.queryParameters["email"];
              return QueryResult(email: email ?? "");
            },
          ),
          GoRoute(
            path: "/productDetailsScreen",
            name: Routes.productDetailsScreen,
            builder: (context, state) {
              final id = state.uri.queryParameters["id"];
              return ProductDetailsScreen(id: id ?? "");
            },
          ),
        ],
      ),
    ],
  );
}

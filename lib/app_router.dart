import 'package:go_router/go_router.dart';
import 'package:velora/login_page.dart';
import 'package:velora/query_result.dart';
import 'package:velora/routes.dart';
import 'sign_up.dart';

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
      GoRoute(
        path: "/query",
        name: Routes.query,
        builder: (context, state) {
          final email = state.uri.queryParameters["email"];
          return QueryResult(email: email ?? "");
        },
      ),
    ],
  );
}

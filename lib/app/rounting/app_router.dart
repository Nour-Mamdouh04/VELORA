import 'package:go_router/go_router.dart';
import 'package:velora/infrastructure/api/api_services.dart';
import 'package:velora/presentation/cubit/home_cubit.dart';
import 'package:velora/presentation/screens/login_page.dart';
import 'package:velora/presentation/screens/product_details_screen.dart';
import 'package:velora/presentation/screens/query_result.dart';
import 'package:velora/app/rounting/routes.dart';
import '../../presentation/screens/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/injection_container.dart';
import 'package:velora/presentation/screen/verification_page.dart';

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
        path: "/verify",
        name: Routes.verify,
        builder: (context, state) {
          
          final email = state.uri.queryParameters["email"];
          return VerificationPage(email: email ?? ""); 
        },
      ),

      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            
            create: (context) => getIt<HomeCubit>()..getProducts(), 
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
            name: Routes.productDetailsScreen,
            path: "/productDetailsScreen",
            builder: (context, state) {
              return ProductDetailsScreen(id: state.uri.queryParameters["id"]!);
            },
          ),
        ],
      ),
    ],
  );
}

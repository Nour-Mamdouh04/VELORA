import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:velora/app/contracts/products_use_case.dart';
import 'package:velora/app/rounting/routes.dart';
import 'package:velora/injection_container.dart';
import 'package:velora/presentation/cubit/home_cubit.dart';
import 'package:velora/presentation/screens/cart_page.dart';
import 'package:velora/presentation/screens/home_page.dart';
import 'package:velora/presentation/screens/login_page.dart';
import 'package:velora/presentation/screens/product_details_screen.dart';
import 'package:velora/presentation/screens/query_result.dart';
import 'package:velora/presentation/screens/settings_page.dart';
import 'package:velora/presentation/screens/sign_up.dart';
import 'package:velora/presentation/screens/verification_page.dart';

class AppRouter {
  static final appRouter = GoRouter(
    initialLocation: "/",

    routes: [
      GoRoute(
        path: "/",
        name: Routes.signUp,
        builder: (context, state) => const SignUp(),
      ),

      GoRoute(
        path: "/verify",
        name: Routes.verify,
        builder: (context, state) => const VerificationPage(email: "email"),
      ),

      GoRoute(
        path: "/login",
        name: Routes.login,
        builder: (context, state) => const MyHomePage(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BlocProvider(
            create: (_) => HomeCubit(productsUseCase: getIt<ProductsUseCase>()),
            child: HomePage(navigationShell: navigationShell),
          );
        },

        branches: [
          // Home (Products)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/query",
                name: Routes.query,
                builder: (context, state) {
                  return const QueryResult();
                },
              ),
            ],
          ),

          // Cart
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/cart",
                name: Routes.cart,
                builder: (context, state) {
                  return const CartPage();
                },
              ),
            ],
          ),

          // Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/settings",
                name: Routes.settings,
                builder: (context, state) {
                  return const SettingsPage();
                },
              ),
            ],
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => HomeCubit(productsUseCase: getIt<ProductsUseCase>()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: "/productDetailsScreen",
            name: Routes.productDetailsScreen,
            builder: (context, state) {
              return ProductDetailsScreen(id: state.uri.queryParameters["id"]!);
            },
          ),
        ],
      ),
    ],
  );
}

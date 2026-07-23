import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:velora/app/contracts/auth_use_case.dart';
import 'package:velora/app/contracts/products_use_case.dart';
import 'package:velora/core/network/api/api_consumer.dart';
import 'package:velora/infrastructure/data_source/abstraction/auth_data_source.dart';
import 'package:velora/infrastructure/data_source/abstraction/products_data_source.dart';
import 'package:velora/infrastructure/data_source/implementation/auth_data_source_imp.dart';
import 'package:velora/infrastructure/data_source/implementation/product_data_source_imp.dart';
import 'package:velora/infrastructure/external/dio/app_interceptor.dart';
import 'package:velora/infrastructure/external/dio/dio_consumer.dart';
import 'package:velora/domain/repos/products_repo.dart';
import 'package:velora/infrastructure/repos/auth_repo_imp.dart';
import 'package:velora/infrastructure/repos/products_repo_imp.dart';
import 'package:velora/presentation/cubit/home_cubit.dart';
import 'package:velora/domain/repos/auth_repo.dart';
import 'package:velora/presentation/cubit/auth_cubit.dart';
import 'package:velora/core/network/api/endpoints.dart';
import 'package:velora/presentation/cubit/cart_cubit.dart'; 

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await InjectionHelper.injectExternal();
  InjectionHelper.injectDatasources();
  InjectionHelper.injectRepos();
  InjectionHelper.injectQueries();
  InjectionHelper.injectUsecases();
  InjectionHelper.injectBlocs();
}

abstract class InjectionHelper {
  static Future<void> injectExternal() async {
    getIt.registerSingleton<Dio>(Dio());

    getIt.registerSingleton<AppInterceptors>(AppInterceptors());

    getIt.registerSingleton<ApiConsumer>(
      DioConsumer(
        client: getIt<Dio>(),
        baseUrl: EndPoints.baseUrl,
        interceptors: [getIt<AppInterceptors>()],
      ),
    );
  }

  static void injectDatasources() {
    getIt.registerLazySingleton<ProductsDataSource>(
      () => ProductDataSourceImp(apiConsumer: getIt<ApiConsumer>()),
    );

    getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
  }

  static void injectRepos() {
    getIt.registerLazySingleton<ProductsRepo>(
      () => ProductsRepoImp(productsDataSource: getIt<ProductsDataSource>()),
    );

    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authDataSource: getIt<AuthDataSource>()),
    );
  }

  static void injectQueries() {}

  static void injectUsecases() {
    getIt.registerFactory<ProductsUseCase>(
      () => ProductsUseCase(productsRepo: getIt<ProductsRepo>()),
    );

    getIt.registerFactory<AuthUseCase>(
      () => AuthUseCase(authRepo: getIt<AuthRepo>()),
    );
  }

  static void injectBlocs() {
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(productsUseCase: getIt<ProductsUseCase>()),
    );

    getIt.registerFactory<AuthCubit>(
      () => AuthCubit(authUseCase: getIt<AuthUseCase>()),
    );

    
    getIt.registerLazySingleton<CartCubit>(() => CartCubit());
  }
}
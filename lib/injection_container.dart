import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:velora/core/network/apis/api_consumer.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/infrastructure/external/dio/dio_consumer.dart';
import 'package:velora/infrastructure/data_source/products_data_source.dart';
import 'package:velora/domain/repos/products_repo.dart';
import 'package:velora/infrastructure/repo/products_repo_impl.dart';
import 'package:velora/app/contract/products_use_case.dart';
import 'package:velora/presentation/cubit/home_cubit.dart';
import 'package:velora/infrastructure/data_source/auth_data_source.dart';
import 'package:velora/domain/repos/auth_repo.dart';
import 'package:velora/infrastructure/repo/auth_repo_impl.dart';
import 'package:velora/app/contract/auth_use_case.dart';
import 'package:velora/presentation/cubit/auth_cubit.dart';



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
    
    
    getIt.registerSingleton<ApiConsumer>(
      DioConsumer(client: getIt<Dio>()),
    );
  }

  static void injectDatasources() {
    
    getIt.registerLazySingleton<ProductsDataSource>(
      () => ProductsDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
    
    
    getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
  }

  static void injectRepos() {
    
    getIt.registerLazySingleton<ProductsRepo>(
      () => ProductsRepoImpl(productsDataSource: getIt<ProductsDataSource>()),
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
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/app/contracts/products_use_case.dart';
import 'package:velora/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.productsUseCase}) : super(InitialState());

  final ProductsUseCase productsUseCase;

  // Future<void> getProducts() async {
  //   emit(ProductsLoadingState());
  //   // try {
  //     final response = await productsUseCase.call();
  //     return response.fold(
  //       (failure) => emit(ProductsFailureState(message: failure.toString())),
  //        (data) => emit(ProductsSuccessState(response: data)),
  //       );

  // }
  Future<void> getProducts() async {
    emit(ProductsLoadingState());

    final response = await productsUseCase.call();

    return response.fold(
      (failure) {
        print("Failure: ${failure.msg}");
        emit(ProductsFailureState(message: failure.msg));
      },
      (data) {
        print("Products Loaded");
        emit(ProductsSuccessState(response: data));
      },
    );
    //   emit(ProductsSuccessState(response: response));
    // } catch (e) {
    //   emit(ProductsFailureState(message: e.toString()));
    // }
  }

  // new

  Future<void> getProductById({required String id}) async {
    emit(GetProductByIdLoadingState());

    final response = await productsUseCase.getProductById(id: id);

    response.fold(
      (failure) {
        emit(GetProductByIdFailureState(message: failure.msg));
      },
      (product) {
        emit(GetProductByIdSuccessState(product: product));
      },
    );
  }
}

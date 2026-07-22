import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/app/contract/products_use_case.dart';
import 'package:velora/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductsUseCase productsUseCase;

  
  HomeCubit({required this.productsUseCase}) : super(InitialState());

  
  Future<void> getProducts() async {
    emit(ProductsLoadingState()); 
    
    final result = await productsUseCase.call();
    
    
    result.fold(
      (failure) => emit(ProductsFailureState(message: failure.msg)),
      (response) => emit(ProductsSuccessState(response: response)),
    );
  }

  
  Future<void> getProductById({required String id}) async {
    switch (state) {
      
      case ProductsSuccessState(:final response):
        emit(GetProductByIdLoadingState(response: response));
        
        final result = await productsUseCase.getProductById(id);
        
        result.fold(
          (failure) => emit(
            GetProductByIdFailureState(message: failure.msg, response: response),
          ),
          (product) => emit(
            GetProductByIdSuccessState(product: product, response: response),
          ),
        );
      default:
        break;
    }
  }
}

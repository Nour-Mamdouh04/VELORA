import 'package:velora/products_model.dart';

abstract class HomeState {

}

class InitialState extends HomeState{}

class ProductsLoadingState extends HomeState{}

class ProductsSuccessState extends HomeState{
  final ProductResponse response;
  ProductsSuccessState({required this.response});
}

class ProductsFailureState extends HomeState{
  final String message;
  ProductsFailureState({required this.message});
}

class GetProductByIdSuccessState extends ProductsSuccessState{
  final Product product;
  
  GetProductByIdSuccessState({required this.product, required super.response});
}
class GetProductByIdLoadingState extends ProductsSuccessState{
  GetProductByIdLoadingState({required super.response});
}

class GetProductByIdFailureState extends ProductsSuccessState{
  final String message;

  GetProductByIdFailureState({required this.message, required super.response});
}
import 'package:velora/domain/models/products_model.dart';

abstract class HomeState {}

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



class GetProductByIdSuccessState extends HomeState {
  final Product product;

  GetProductByIdSuccessState({
    required this.product,
  });
}

class GetProductByIdLoadingState extends HomeState {}

class GetProductByIdFailureState extends HomeState {
  final String message;

  GetProductByIdFailureState({
    required this.message,
  });
}
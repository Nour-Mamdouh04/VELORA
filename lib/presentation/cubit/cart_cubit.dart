import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/domain/models/products_model.dart';

class CartCubit extends Cubit<List<Product>> {
  CartCubit() : super([]);

  
  void addToCart(Product product) {
    final updatedList = List<Product>.from(state)..add(product);
    emit(updatedList);
  }

  void removeFromCart(Product product) {
    final updatedList = List<Product>.from(state)..remove(product);
    emit(updatedList);
  }


  void clearCart() {
    emit([]);
  }
}
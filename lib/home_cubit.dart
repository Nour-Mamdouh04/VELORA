import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/api_services.dart';
import 'package:velora/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.apiServices}) : super(InitialState());

  final ApiServices apiServices;

  Future<void> getProducts() async {
    emit(ProductsLoadingState());
    try {
      final response = await apiServices.products();
      emit(ProductsSuccessState(response: response));
    } catch (e) {
      emit(ProductsFailureState(message: e.toString()));
    }
  }

  Future<void> getProductById({required String id}) async {
    switch (state) {
      case ProductsSuccessState(:final response):
        emit(GetProductByIdLoadingState(response: response));

        try {
          final product = await apiServices.getProductById(id: id);

          emit(
            GetProductByIdSuccessState(product: product, response: response),
          );
        } catch (e) {
          emit(
            GetProductByIdFailureState(
              message: e.toString(),
              response: response,
            ),
          );
        }

      default:
        break;
    }
  }
}

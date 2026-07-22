import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/domain/models/products_model.dart';
import 'package:velora/domain/repos/products_repo.dart';

class ProductsUseCase {
  final ProductsRepo productsRepo;

  ProductsUseCase({required this.productsRepo});

  Future<Either<Failure, ProductResponse>> call() async {
    return await productsRepo.getProducts();
  }
  // new
  Future<Either<Failure, Product>> getProductById({required String id}) {
    return productsRepo.getProductById(id: id);
  }
}

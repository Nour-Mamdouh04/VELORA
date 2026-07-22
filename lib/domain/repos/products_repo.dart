import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/domain/models/products_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, ProductResponse>> getProducts();
  // new
  Future<Either<Failure, Product>> getProductById({required String id});
}

import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';

abstract class ProductsDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getProducts();
  // new
  Future<Either<Failure, Map<String, dynamic>>> getProductById({
    required String id,
  });
}

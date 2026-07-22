import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/domain/models/products_model.dart';
import 'package:velora/domain/repos/products_repo.dart';
import 'package:velora/infrastructure/data_source/abstraction/products_data_source.dart';

class ProductsRepoImp implements ProductsRepo {
  final ProductsDataSource productsDataSource;

  ProductsRepoImp({required this.productsDataSource});

  @override
  Future<Either<Failure, ProductResponse>> getProducts() async {
    try {
      final response = await productsDataSource.getProducts();
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(ProductResponse.fromJson(data)),
      );
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
  // new
  @override
  Future<Either<Failure, Product>> getProductById({required String id}) async {
    try {
      final response = await productsDataSource.getProductById(id: id);

      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(Product.fromJson(data)),
      );
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/domain/models/products_model.dart';
import 'package:velora/domain/repos/products_repo.dart';
import 'package:velora/infrastructure/data_source/products_data_source.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ProductsDataSource productsDataSource;

  ProductsRepoImpl({required this.productsDataSource});

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

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final response = await productsDataSource.getProductById(id);
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(Product.fromJson(data)),
      );
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
}
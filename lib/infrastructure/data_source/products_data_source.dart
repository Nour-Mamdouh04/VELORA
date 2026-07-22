import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/apis/api_consumer.dart';
import 'package:velora/core/network/errors/failure.dart';

abstract class ProductsDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getProducts();
  Future<Either<Failure, Map<String, dynamic>>> getProductById(String id);
}


class ProductsDataSourceImpl implements ProductsDataSource {
  final ApiConsumer apiConsumer;

  ProductsDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProducts() async {
    try {
      final response = await apiConsumer.get(path: "/products");
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductById(String id) async {
    try {
      final response = await apiConsumer.get(path: "/products/$id");
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}
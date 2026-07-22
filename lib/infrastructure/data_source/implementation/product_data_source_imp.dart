import 'package:fpdart/fpdart.dart';
import 'package:velora/core/network/api/api_consumer.dart';
import 'package:velora/core/network/api/endpoints.dart';
import 'package:velora/core/network/errors/failure.dart';
import 'package:velora/infrastructure/data_source/abstraction/products_data_source.dart';

class ProductDataSourceImp implements ProductsDataSource {
  final ApiConsumer apiConsumer;
  ProductDataSourceImp({required this.apiConsumer});

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProducts() async {
    try {
      final response = await apiConsumer.get(path: EndPoints.products);
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
  // new
  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductById({
    required String id,
  }) async {
    try {
      final response = await apiConsumer.get(path: "${EndPoints.products}/$id");

      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}

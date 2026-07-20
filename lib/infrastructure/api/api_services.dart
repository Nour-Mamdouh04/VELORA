import 'package:dio/dio.dart';
import "dart:developer";
import 'package:velora/domain/models/products_model.dart';

class ApiServices {
  final Dio apiService = Dio(
    BaseOptions(baseUrl: "https://accessories-eshop.runasp.net/api"),
  );

  Future<ProductResponse> products() async {
    try {
      final response = await apiService.get("/products");

      if (response.statusCode == 200) {
        log(response.data.toString());
        return ProductResponse.fromJson(response.data);
      } else {
        log(response.statusMessage.toString());
        return ProductResponse.fromJson({});
      }
    } on DioException catch (e) {
      log(e.message ?? "");
      return ProductResponse.fromJson({});
    }
  }

  Future<Product> getProductById({required String id}) async {
    try {
      final response = await apiService.get("/products/$id");

      if (response.statusCode == 200) {
        log(response.data.toString());
        return Product.fromJson(response.data);
      } else {
        log(response.statusMessage.toString());
        return Product.fromJson({});
      }
    } on DioException catch (e) {
      log(e.message ?? "");
      return Product.fromJson({});
    }
  }
}

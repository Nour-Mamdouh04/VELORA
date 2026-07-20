import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:velora/api_services.dart';
import 'package:velora/home_cubit.dart';
import 'package:velora/home_state.dart';
import 'routes.dart';
import 'dart:developer';

class QueryResult extends StatefulWidget {
  const QueryResult({super.key, this.email});

  final String? email;

  @override
  State<QueryResult> createState() => _QueryResultState();
}

class _QueryResultState extends State<QueryResult> {
  final ApiServices apiService = ApiServices();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          "Our Products",
          style: TextStyle(
            fontFamily: "DMSans",
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 121, 113, 72),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            ProductsLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),

            ProductsFailureState() => const Center(
              child: Text(
                "Failed to load products",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),

            ProductsSuccessState(:final response) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: response.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(149, 216, 188, 133),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      onTap: () {
                        // log(response.items[index].id);
                        context.pushNamed(
                          Routes.productDetailsScreen,
                          queryParameters: {
                            "id": response.items[index].id.toString(),
                          },
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              response.items[index].coverPictureUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey.shade200,
                                      alignment: Alignment.center,
                                      child: const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                        ),
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  color: const Color.fromARGB(
                                    255,
                                    176,
                                    138,
                                    78,
                                  ),
                                  child: const Icon(Icons.broken_image),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  response.items[index].name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  response.items[index].description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  "${response.items[index].price} EGP",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 83, 88, 83),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

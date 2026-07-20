import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/presentation/cubit/home_cubit.dart';
import 'package:velora/presentation/cubit/home_state.dart';
import 'package:go_router/go_router.dart';
import 'package:velora/core/utils/app_theme_cubit.dart';
import 'package:velora/core/utils/app_theme_state.dart';
import 'package:velora/core/widgets/custom_app_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProductById(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(
            fontFamily: "DMSans",
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 121, 113, 72),
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<AppThemeCubit, AppThemeState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(state.isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  context.read<AppThemeCubit>().toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            GetProductByIdLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            GetProductByIdFailureState(:final message) => Center(
              child: Text(
                "Error: $message",
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            GetProductByIdSuccessState(:final product) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Hero(
                      tag: product.id,
                      child: Image.network(
                        product.coverPictureUrl,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 300,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image, size: 50),
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),

                        Text(
                          product.name,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 121, 113, 72),
                            fontSize: 24,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          "${product.price} EGP",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 57, 132, 59),
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${product.rating.toStringAsFixed(1)} (${product.reviewsCount} reviews)",
                                    style: const TextStyle(
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                product.stock > 0
                                    ? "In Stock (${product.stock})"
                                    : "Out of Stock",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 121, 113, 72),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "DMSans",

                            color: Theme.of(context).textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.8),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 25),

                        const Text(
                          "Specifications",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 121, 113, 72),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.scale,
                                      size: 20,
                                      color: Color.fromARGB(255, 121, 113, 72),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Weight",
                                      style: TextStyle(
                                        fontSize: 11,

                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${product.weight} kg",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.palette,
                                      size: 20,
                                      color: Color.fromARGB(255, 121, 113, 72),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Color",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product.color,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 6),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.local_offer,
                                      size: 20,
                                      color: Color.fromARGB(255, 121, 113, 72),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Discount",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${product.discountPercentage}%",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        Center(
                          child: CustomAppButton(
                            title: "Add to Bag",
                            fontWeight: FontWeight.bold,
                            backgroundColor: const Color.fromARGB(
                              255,
                              121,
                              113,
                              72,
                            ),
                            textColor: Colors.white,
                            onPress: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${product.name} added to bag!",
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

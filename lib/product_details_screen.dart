import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/home_cubit.dart';
import 'package:velora/home_state.dart';

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
    context.read()<HomeCubit>().getProductById(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            GetProductByIdLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            GetProductByIdFailureState(:final message) => Center(
              child: Text(
                "Error: $message}",
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
            ),
            GetProductByIdSuccessState(:final product) => Center(
              child: Column(
                children: [
                  Image.network(product.coverPictureUrl),
                  Text(product.name),
                ],
              ),
            ),
            _ => SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

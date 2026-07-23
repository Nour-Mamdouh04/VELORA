import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:velora/core/widgets/custom_app_button.dart';
import 'package:velora/domain/models/products_model.dart';
import 'package:velora/presentation/cubit/cart_cubit.dart';
import 'package:velora/core/utils/app_theme_cubit.dart';
import 'package:velora/core/utils/app_theme_state.dart';
import 'package:velora/app/rounting/routes.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(Routes.query); 
          },
        ),
        title: const Text(
          "Cart",
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
                icon: Icon(
                  state.isDark ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  context.read<AppThemeCubit>().toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      
      body: BlocBuilder<CartCubit, List<Product>>(
        builder: (context, cartItems) {
         
          if (cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

        
          final totalPrice = cartItems.fold<num>(0, (sum, item) => sum + item.price);

         
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartItems.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.coverPictureUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                           
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DMSans",
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "${item.price} EGP",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 121, 113, 72),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                           
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () {
                                context.read<CartCubit>().removeFromCart(item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${item.name} removed from cart")),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

         
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DMSans",
                          ),
                        ),
                        Text(
                          "$totalPrice EGP",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 121, 113, 72),
                            fontFamily: "DMSans",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomAppButton(
                      title: "Proceed to Checkout",
                      fontWeight: FontWeight.bold,
                      backgroundColor: const Color.fromARGB(255, 121, 113, 72),
                      textColor: Colors.white,
                      onPress: () {
                  
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
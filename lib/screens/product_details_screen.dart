import 'package:bounce/bounce.dart';
import 'package:diploy_assignment/core/constants/colors.dart';
import 'package:diploy_assignment/data/model/product.dart';
import 'package:diploy_assignment/provider/cart_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 40,
                          color: AppColors.textDark,
                        )),
                    Consumer<CartProvider>(
                      builder: (_, cart, __) => Stack(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              size: 40,
                              color: AppColors.textDark,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/cart');
                            },
                          ),
                          if (cart
                              .cartItems.isNotEmpty) // Check if cart has items
                            Positioned(
                              right: 2, // Positioning the badge
                              top: 2,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.red, // Badge color
                                  shape: BoxShape.circle, // Circular badge
                                ),
                                child: Text(
                                  cart.cartItems.length
                                      .toString(), // Display cart item count
                                  style: const TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 14, // Font size for badge text
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Bounce(
                  child: InkWell(
                    onTap: () {
                      cartProvider.addProduct(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${product.name} added to cart')),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.textDark),
                      child: const Center(
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.background),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(product.description,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey)),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

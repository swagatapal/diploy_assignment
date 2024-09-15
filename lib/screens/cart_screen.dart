import 'package:diploy_assignment/core/constants/colors.dart';
import 'package:diploy_assignment/data/repositories/product_repository.dart';
import 'package:diploy_assignment/provider/cart_provider.dart';
import 'package:diploy_assignment/widgets/cart_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/empty_cart_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 40,
                  )),
              const Text(
                "Cart Items",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark),
              ),
              cartProvider.cartItems.isEmpty
                  ? const Center(child: EmptyCartWidget())
                  : Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (ctx, i) {
                          final productId =
                              cartProvider.cartItems.keys.toList()[i];
                          final quantity = cartProvider.cartItems[productId]!;
                          final product = ProductRepository()
                              .getProducts()
                              .firstWhere((p) => p.id == productId);

                          return CartCardWidget(
                            quantity: quantity.toString(),
                            image: product.imageUrl,
                            price: product.price.toString(),
                            name: product.name,
                            onClicked: () {
                              cartProvider.removeProduct(productId);
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColors.textDark),
          child: Center(
            child: Text(
                'Total:  \$ ${cartProvider.totalPrice.toStringAsFixed(2)}',
                style:
                    const TextStyle(color: AppColors.background, fontSize: 24)),
          ),
        ),
      ),
    );
  }
}

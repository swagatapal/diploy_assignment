import 'package:diploy_assignment/core/constants/colors.dart';
import 'package:diploy_assignment/data/model/product.dart';
import 'package:diploy_assignment/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.2,
            decoration: BoxDecoration(
              color: AppColors.textLight,
              borderRadius: BorderRadius.circular(10),
              boxShadow:  [
                BoxShadow(
                  color: AppColors.textDark.withOpacity(0.05), // Shadow color
                  offset: const Offset(0, 1), // X and Y offsets
                  blurRadius: 8, // Blur radius
                  spreadRadius: 0, // Spread radius
                ),
              ],
            ),


            child: Row(
              children: [
                Hero(
                  tag: product.id,
                  child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.2),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4, style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 10,),
                        Text('\$${product.price}', style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

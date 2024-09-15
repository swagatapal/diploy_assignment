import 'package:bounce/bounce.dart';
import 'package:diploy_assignment/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CartCardWidget extends StatelessWidget {
  final String image;
  final String price;
  final String name;
  final String quantity;
  late Function()? onClicked;

  CartCardWidget(
      {super.key,
        required this.quantity,
        required this.image,
        required this.price,
        required this.name,
        this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            color: AppColors.textLight,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
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
              // Image container
              Container(
                child: Image.network(image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.15),
              ),

              // Expanded to ensure the content fits the remaining space
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Product name with ellipsis and two lines max
                      Text(name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      // Price
                      Text('\$$price',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey)),
                      const SizedBox(height: 10,),
                      Text('Quantity: $quantity', style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                        fontSize: 18
                      ),),
                    ],
                  ),
                ),
              ),

              // Delete Icon Button
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Bounce(
                  child: InkWell(
                    onTap: onClicked,
                    child: const Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

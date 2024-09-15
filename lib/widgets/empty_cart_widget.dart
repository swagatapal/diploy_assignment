import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(
           height: MediaQuery.of(context).size.height*0.2,
         ),
        const Text("Sorry!! The Cart is empty \n "
            "Browse the Product and add your cart",textAlign: TextAlign.center, style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.red
        ),),
      ],
    );
  }
}

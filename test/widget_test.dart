
import 'package:diploy_assignment/data/model/product.dart';
import 'package:diploy_assignment/provider/cart_provider.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('Add product to cart', () {
    final cartProvider = CartProvider();
    final product = Product(id: '1', name: 'Test Product', imageUrl: '', description: '', price: 100.0);

    cartProvider.addProduct(product);
    expect(cartProvider.cartItems[product.id], 1);
  });
}

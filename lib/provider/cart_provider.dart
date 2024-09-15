import 'dart:convert';

import 'package:diploy_assignment/data/model/product.dart';
import 'package:diploy_assignment/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  Map<String, int> _cartItems = {};

  Map<String, int> get cartItems => _cartItems;

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      _cartItems = Map<String, int>.from(jsonDecode(cartData));
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id] = _cartItems[product.id]! + 1;
    } else {
      _cartItems[product.id] = 1;
    }
    await _saveCart();
    notifyListeners();
  }

  Future<void> removeProduct(String productId) async {
    _cartItems.remove(productId);
    await _saveCart();
    notifyListeners();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', jsonEncode(_cartItems));
  }

  double get totalPrice {
    double total = 0;
    _cartItems.forEach((key, quantity) {
      final product = ProductRepository()
          .getProducts()
          .firstWhere((product) => product.id == key);
      total += product.price * quantity;
    });
    return total;
  }
}

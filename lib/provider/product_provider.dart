import 'package:diploy_assignment/data/model/product.dart';
import 'package:flutter/material.dart';
import '../data/repositories/product_repository.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    _products = ProductRepository().getProducts();
    notifyListeners();
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
}

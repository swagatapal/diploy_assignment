import 'package:diploy_assignment/core/constants/colors.dart';
import 'package:diploy_assignment/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProductProvider>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products
        .where((product) =>
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Product List',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Container(
                height: 50, // Adjust the height as needed
                width: MediaQuery.of(context)
                    .size
                    .width, // Adjust width for padding
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0), // Padding inside the container
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      offset: const Offset(0, 4), // Offset of the shadow
                      blurRadius: 8, // Blur radius
                      spreadRadius: 0, // Spread radius
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search,
                        size: 24,
                        color: Colors.grey), // Icon inside the search bar
                    const SizedBox(
                        width: 10), // Space between the icon and text field
                    Expanded(
                      child: TextField(
                        controller: _searchController, // Bind controller
                        onChanged: (value) {
                          setState(() {
                            _searchQuery =
                                value; // Update search query on input
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search products...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none, // Removes the border
                          contentPadding: EdgeInsets.all(
                              0), // Padding inside the text field
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: Lottie.asset("asset/animation/loading.json",
                          height: 200, width: 200))
                  : products.isEmpty
                      ? const Center(
                          child: Text(
                          'No Products Found !! \n please type valid product name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ))
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (ctx, i) =>
                              ProductItem(product: products[i]),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

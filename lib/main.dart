import 'package:diploy_assignment/provider/cart_provider.dart';
import 'package:diploy_assignment/provider/product_provider.dart';
import 'package:diploy_assignment/screens/cart_screen.dart';
import 'package:diploy_assignment/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()..loadCart()),
      ],
      child: MaterialApp(
        title: 'Advanced Product App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
        routes: {
          '/cart': (ctx) => CartScreen(),
        },
      ),
    );
  }
}
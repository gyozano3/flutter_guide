import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section8/pages/cart_page.dart';
import 'package:section8/pages/order_page.dart';
import 'package:section8/pages/product_detail_page.dart';
import 'package:section8/pages/product_overview_page.dart';
import 'package:section8/providers/cart.dart';
import 'package:section8/providers/orders.dart';
import 'package:section8/providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
          title: 'myshop',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                  .copyWith(secondary: Colors.yellow),
              fontFamily: 'Lato'),
          home: ProductOverviewPage(),
          routes: {
            ProductDetailPage.routeName: (ctx) => const ProductDetailPage(),
            CartPage.routeName: (ctx) => const CartPage(),
            OrderPage.routeName: (ctx) => const OrderPage(),
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section8/providers/orders.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart' as oi;

class OrderPage extends StatelessWidget {
  static String routeName = '/order';
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _cart = Provider.of<Cart>(context);
    final order = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('your orders'),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemBuilder: (ctx, i) => oi.OrderItem(order.orders[i]),
          itemCount: order.orders.length,
        ));
  }
}

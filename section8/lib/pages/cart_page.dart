import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section8/providers/orders.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  static String routeName = '/cart';
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    // final _items = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('your cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                      label: Text(
                    '\$${_cart.totalPrice}',
                  )),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            _cart.items.values.toList(), _cart.totalPrice);
                        _cart.clear();
                      },
                      child: Text('Order now'))
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CartItem(
              [..._cart.items.values][i].id,
              [..._cart.items.keys][i],
              [..._cart.items.values][i].title,
              [..._cart.items.values][i].quantity,
              [..._cart.items.values][i].price,
            ),
            itemCount: _cart.items.length,
          ))
        ],
      ),
    );
  }
}

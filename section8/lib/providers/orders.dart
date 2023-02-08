import 'package:flutter/material.dart';
import 'package:section8/providers/cart.dart';
import 'package:uuid/uuid.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> cartItems;
  final DateTime dateTime;
  OrderItem(
      {required this.id,
      required this.amount,
      required this.cartItems,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> order, double total) {
    var uuid = Uuid();

    _orders.insert(
        0,
        OrderItem(
            id: uuid.v4(),
            amount: total,
            cartItems: order,
            dateTime: DateTime.now()));

    notifyListeners();
  }
}

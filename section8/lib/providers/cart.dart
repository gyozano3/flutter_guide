import 'package:flutter/material.dart';
import 'package:section8/providers/product.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    var uuid = Uuid();
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (item) => CartItem(
                id: item.id,
                title: item.title,
                quantity: item.quantity + 1,
                price: item.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: uuid.v4(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeItem(
    String id,
  ) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

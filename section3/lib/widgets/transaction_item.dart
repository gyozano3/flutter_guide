import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color bgColor;
  @override
  void initState() {
    const bgcolors = [
      Colors.red,
      Colors.purple,
      Colors.green,
      Colors.blue,
      Colors.yellow
    ];
    bgColor = bgcolors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 13,
      color: Theme.of(context).canvasColor,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$${widget.userTransaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).selectedRowColor,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.userTransaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat('yyyy/MM/dd').format(widget.userTransaction.date),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTransaction(widget.userTransaction.id),
        ),
      ),
    );
  }
}

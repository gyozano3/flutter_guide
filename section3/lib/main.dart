import 'package:flutter/material.dart';
import 'package:section3/widgets/chart.dart';
import 'package:section3/widgets/new_transaction.dart';
import 'package:section3/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        // fontFamily: 'yuzupop',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransctions = [];

  List<Transaction> get _recentTransactions {
    return _userTransctions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime picked) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: picked,
    );
    setState(() {
      _userTransctions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransctions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddTransction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return NewTransction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('家計簿'),
        actions: [
          IconButton(
            onPressed: () => _startAddTransction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            child: Chart(_userTransctions),
            width: double.infinity,
            height: 160,
          ),
          Expanded(
              child: TransctionList(_recentTransactions, _deleteTransaction)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddTransction(context),
      ),
    );
  }
}

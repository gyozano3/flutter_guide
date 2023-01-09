import 'package:flutter/material.dart';
import 'package:section3/models/transaction.dart';
import 'package:section3/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> userTransactions = [];
  final Function deleteTransaction;
  TransactionList(this.userTransactions, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userTransactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  const Text('no transaction'),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                    key: ValueKey(userTransactions[index].id),
                    userTransaction: userTransactions[index],
                    deleteTransaction: deleteTransaction);
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}

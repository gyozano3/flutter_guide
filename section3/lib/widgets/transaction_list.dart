import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:section3/models/transaction.dart';

class TransctionList extends StatelessWidget {
  List<Transaction> userTransctions = [];
  final Function deleteTransaction;
  TransctionList(this.userTransctions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userTransctions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Text('no transaction'),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Container(
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
                return Card(
                  elevation: 13,
                  color: Theme.of(context).canvasColor,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            '\$${userTransctions[index].amount.toStringAsFixed(2)}',
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
                      userTransctions[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat('yyyy/MM/dd')
                          .format(userTransctions[index].date),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          deleteTransaction(userTransctions[index].id),
                    ),
                  ),
                );
              },
              itemCount: userTransctions.length,
            ),
    );
  }
}

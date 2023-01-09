import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:section3/widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> userTransactions = [];
  Chart(this.userTransactions);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmount = 0;
      for (int i = 0; i < userTransactions.length; i++) {
        if (userTransactions[i].date.day == weekDay.day &&
            userTransactions[i].date.month == weekDay.month &&
            userTransactions[i].date.year == weekDay.year) {
          totalAmount += userTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get maxSp {
    return transactionValues.fold(
        0, (sum, item) => sum + (item['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'] as String,
                e['amount'] as double,
                maxSp == 0 ? 0 : (e['amount'] as double) / maxSp,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

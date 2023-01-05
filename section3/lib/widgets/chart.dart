import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:section3/widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> userTransctions = [];
  Chart(this.userTransctions);

  List<Map<String, Object>> get transctionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmount = 0;
      for (int i = 0; i < userTransctions.length; i++) {
        if (userTransctions[i].date.day == weekDay.day &&
            userTransctions[i].date.month == weekDay.month &&
            userTransctions[i].date.year == weekDay.year) {
          totalAmount += userTransctions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get maxSp {
    return transctionValues.fold(
        0, (sum, item) => sum + (item['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transctionValues.map((e) {
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

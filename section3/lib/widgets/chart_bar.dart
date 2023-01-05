import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double total;
  ChartBar(this.label, this.amount, this.total);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text('\$${amount.toStringAsFixed(0)}'),
          ),
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 1,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20))),
              FractionallySizedBox(
                heightFactor: total,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}

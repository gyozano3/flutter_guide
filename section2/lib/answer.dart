import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback select;
  final String text;
  const Answer({required this.select, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        onPressed: select,
        child: Text(text),
      ),
    );
  }
}

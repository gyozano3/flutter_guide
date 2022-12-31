import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  int i = 0;
  VoidCallback reset;

  Result(this.i, this.reset);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('done :' + i.toString()),
        ElevatedButton(onPressed: reset, child: Text('reset'))
      ],
    );
  }
}

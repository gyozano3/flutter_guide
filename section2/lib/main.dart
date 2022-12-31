import 'package:flutter/material.dart';
import 'package:section2/answer.dart';
import 'package:section2/result.dart';

import 'anslist.dart';
import 'question.dart';
import 'result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('my first'),
          ),
          body: Sample()),
    );
  }
}

class Sample extends StatefulWidget {
  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  var _q = [
    {
      'text': 'do you need friend?',
      'ans': [
        {'text': 'yes', 'score': 2},
        {'text': 'no', 'score': 1}
      ]
    },
    {
      'text': 'do you need girlfriend?',
      'ans': [
        {'text': 'yes!', 'score': 2},
        {'text': 'no!', 'score': 1}
      ]
    },
    {
      'text': 'do you trust girl?',
      'ans': [
        {'text': 'yes', 'score': 2},
        {'text': 'no', 'score': 1},
        {'text': 'unknown', 'score': 1}
      ]
    },
  ];
  var i = 0;
  var total = 0;
  _doaa(int score) {
    total += score;
    setState(() => i++);
  }

  reset() {
    total = 0;
    setState(() => i = 0);
  }

  @override
  Widget build(BuildContext context) {
    return (i < _q.length)
        ? AnsList(q: _q, i: i, doaa: _doaa)
        : Result(total, reset);
  }
}

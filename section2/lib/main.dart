import 'package:flutter/material.dart';
import 'package:section2/result.dart';

import 'anslist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('my first'),
          ),
          body: const Sample()),
    );
  }
}

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  final _q = [
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

import 'package:flutter/material.dart';
import 'package:section2/question.dart';

import 'answer.dart';

class AnsList extends StatelessWidget {
  final List<Map<String, Object>> q;
  final int i;
  final Function doaa;

  const AnsList(
      {super.key, required this.q, required this.i, required this.doaa});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(q[i]['text'] as String),
        ...(q[i]['ans'] as List<Map<String, Object>>).map((i) =>
            Answer(select: () => doaa(i['score']), text: i['text'] as String)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransction(this.addNewTransaction);

  @override
  State<NewTransction> createState() => _NewTransctionState();
}

class _NewTransctionState extends State<NewTransction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime pickedDate = DateTime.now();

  void _submitData() {
    String title = titleController.text;
    double amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0) {
      return;
    }
    widget.addNewTransaction(
      title,
      amount,
      pickedDate,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((picked) {
      if (picked == null) {
        return;
      }
      setState(() {
        pickedDate = picked;
      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => titleInput = val,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                            'Picked:${DateFormat.yMd().format(pickedDate)}')),
                    SizedBox(
                      width: 50,
                    ),
                    OutlinedButton(
                        onPressed: _datePicker,
                        style: ButtonStyle(),
                        child: Text('chose date')),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: _submitData,
                  style: ButtonStyle(),
                  child: Text('save')),
            ],
          ),
        ),
      ),
    );
  }
}

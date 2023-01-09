import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const NewTransaction(this.addNewTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
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
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => titleInput = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                            'Picked:${DateFormat.yMd().format(pickedDate)}')),
                    const SizedBox(
                      width: 50,
                    ),
                    OutlinedButton(
                        onPressed: _datePicker,
                        style: const ButtonStyle(),
                        child: const Text('chose date')),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: _submitData,
                  style: const ButtonStyle(),
                  child: const Text('save')),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense_model.dart';

class ExpenseCreate extends StatefulWidget {
  const ExpenseCreate(this.addExpense, {super.key});

  final Function addExpense;

  @override
  State<ExpenseCreate> createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? title;
  double? price;
  DateTime? date;
  Category category = Category.leisure;

  void saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.addExpense(Expense(
          title: title!, price: price!, category: category, date: date!));
      Navigator.pop(context);
    }
  }

  void showDatePickerDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime.now(),
    ).then((value) {
      print(value);
      setState(() {
        date = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(labelText: "Title"),
                onSaved: (newValue) => title = newValue,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter title";
                  }
                  return null;
                },
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                    prefixText: "\$ ", labelText: "Amount Spent"),
                onSaved: (newValue) => price = double.tryParse(newValue!),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.parse(value) <= 0) {
                    return "Enter amount";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: category,
                    items: Category.values
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                  const Spacer(),
                  (date == null)
                      ? Text(
                          "No date choosen",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      : Text(DateFormat.yMMMd().format(date!),
                          style: Theme.of(context).textTheme.bodySmall),
                  TextButton.icon(
                      onPressed: showDatePickerDialog,
                      icon: Icon(Icons.date_range),
                      label: Text("Pick a date"))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: saveForm,
                  child: const Text("Add data"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

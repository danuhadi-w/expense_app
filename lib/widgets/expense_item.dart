import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense_model.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    required this.title,
    required this.price,
    required this.category,
    required this.date,
    super.key,
  });

  final String title;
  final double price;
  final Category category;
  final DateTime date;

  static const categoryIcons = [
    Icons.travel_explore,
    Icons.work,
    Icons.airplanemode_active,
    Icons.fastfood
  ];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text("\$$price", style: Theme.of(context).textTheme.bodySmall),
      trailing: SizedBox(
        width: 120,
        child: Row(children: [
          Icon(categoryIcons[category.index]),
          Spacer(),
          Text(DateFormat.yMMMd().format(date),
              style: Theme.of(context).textTheme.bodySmall),
        ]),
      ),
    );
  }
}

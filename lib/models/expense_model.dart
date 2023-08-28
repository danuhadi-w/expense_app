class Expense {
  final String title;
  final double price;
  final Category category;
  final DateTime date;

  Expense({
    required this.title,
    required this.price,
    required this.category,
    required this.date,
  });
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    var temp = 0.0;
    expenses.fold(temp, (prevsValue, element) => temp = element.price);
    return temp;
  }
}

enum Category {
  leisure,
  work,
  travel,
  food,
}

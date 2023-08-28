import 'package:flutter/material.dart';

import '../widgets/expense_item.dart';
import '../widgets/expense_create.dart';
import '../models/expense_model.dart';
import '../widgets/chart/chart.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static List<Expense> expenses = [
    // Expense(
    //   title: "Books",
    //   price: 10.00,
    //   category: Category.work,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   title: "Foods",
    //   price: 33.00,
    //   category: Category.food,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   title: "Groceries",
    //   price: 55.00,
    //   category: Category.food,
    //   date: DateTime.now(),
    // ),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void addExpense(Expense expense) {
    setState(() {
      MainScreen.expenses.add(expense);
    });
  }

  void openFSModal(BuildContext context) {
    showModalBottomSheet(
      shape: Border.all(width: 1),
      isScrollControlled: true,
      context: context,
      builder: ((ctx) => ExpenseCreate(addExpense)),
    );
  }

  Future<void> removeSingleExpense(int index) {
    var tempData = MainScreen.expenses.elementAt(index);
    return Future.delayed(Duration.zero, () {
      setState(() {
        MainScreen.expenses.removeAt(index);
      });
    }).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(children: [
              const Text(
                "Item removed",
                style: TextStyle(fontSize: 12),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    setState(() {
                      MainScreen.expenses.insert(index, tempData);
                    });
                    ScaffoldMessenger.of(context).clearSnackBars();
                  },
                  child: const Text("UNDO", style: TextStyle(fontSize: 12)))
            ]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            openFSModal(context);
          }),
      appBar: AppBar(
        title: const Text("Expense App"),
        actions: [
          IconButton(
            onPressed: () => openFSModal(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Chart(expenses: MainScreen.expenses),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                child: MainScreen.expenses.isEmpty
                    ? const Center(
                        child: Text("No data, please add some~"),
                      )
                    : ListView.builder(
                        itemCount: MainScreen.expenses.length,
                        itemBuilder: ((ctx, index) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              removeSingleExpense(index);
                            },
                            confirmDismiss: (direction) {
                              return showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text("Are you sure?"),
                                    content: Text("Remove item from list?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text("No")),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: Text("Yes"))
                                    ],
                                  );
                                },
                              );
                            },
                            background: Card(
                              color: Colors.red,
                            ),
                            key: ValueKey(index),
                            child: Card(
                              child: ExpenseItem(
                                  title: MainScreen.expenses[index].title,
                                  price: MainScreen.expenses[index].price,
                                  category: MainScreen.expenses[index].category,
                                  date: MainScreen.expenses[index].date),
                            ),
                          );
                          // print(expenses[index].title);
                        }),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

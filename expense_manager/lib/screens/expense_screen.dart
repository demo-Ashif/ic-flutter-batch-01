import 'package:expense_manager/enums/category_enums.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../widgets/expense_list.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  //dummy data
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: ExpenseCategory.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: ExpenseCategory.leisure,
    ),
  ];

  void _openAddExpenseModal() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Text('Modal Bottom Sheet'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseModal,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Text('Expense Chart'),
          Expanded(
            child: ExpenseList(
              expenses: _registeredExpenses,
            ),
          )
        ],
      ),
    );
  }
}

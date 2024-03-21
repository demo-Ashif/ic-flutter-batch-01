import 'package:expense_manager/enums/category_enums.dart';
import 'package:expense_manager/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/expense.dart';
import '../widgets/expense_list.dart';
import 'new_expense.dart';

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
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    //show undo option and insert if undo clicked
    //Snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Expense Manager'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseModal,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: ExpenseList(
                    expenses: _registeredExpenses,
                    onRemoveExpense: _removeExpense,
                  ),
                )
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: ExpenseList(
                    expenses: _registeredExpenses,
                    onRemoveExpense: _removeExpense,
                  ),
                )
              ],
            ),
    );
  }
}

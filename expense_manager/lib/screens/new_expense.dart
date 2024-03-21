import 'package:expense_manager/enums/category_enums.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.leisure;

  //Date picker related
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //saving new expense
  void _submitExpenseData() {
    final enteredAmount =
        double.tryParse(_amountController.text); // 1.12 => 1.12, 'Hello' =>null
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    //check all input
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text(
              'Pleas make sure you have entered valid title, amount, category and date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay'),
            )
          ],
        ),
      );

      return;
    }

    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );

    Navigator.pop(context);
  }

  //reset dropdown
  void _resetCategoryDropdown(value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (ctx, constraints) {
        final maxWidth = constraints.maxWidth;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Column(
              children: [
                maxWidth > 600
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: TitleWidget(
                                  titleController: _titleController)),
                          const SizedBox(width: 16),
                          Expanded(
                              child: AmountWidget(
                                  amountController: _amountController))
                        ],
                      )
                    : TitleWidget(titleController: _titleController),
                const SizedBox(height: 16),
                maxWidth > 600
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CategoryDropdownWidget(
                            selectedCategory: _selectedCategory,
                            onExpenseCategoryChanged: _resetCategoryDropdown,
                          ),
                          SizedBox(width: 16),
                          Text(
                            _selectedDate == null
                                ? 'No Date Selected'
                                : formatter.format(_selectedDate!),
                          ),
                          DatePickWidget(onDateSelected: _presentDatePicker),
                          CancelButtonWidget(),
                          SaveButtonWidget(onPressed: _submitExpenseData)
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AmountWidget(
                                amountController: _amountController),
                          ),
                          SizedBox(width: 16),
                          Text(
                            _selectedDate == null
                                ? 'No Date Selected'
                                : formatter.format(_selectedDate!),
                          ),
                          DatePickWidget(onDateSelected: _presentDatePicker)
                        ],
                      ),
                const SizedBox(height: 16),
                maxWidth > 600
                    ? SizedBox.shrink()
                    : Row(
                        children: [
                          //Category DropDown
                          CategoryDropdownWidget(
                            selectedCategory: _selectedCategory,
                            onExpenseCategoryChanged: _resetCategoryDropdown,
                          ),
                          const Spacer(),
                          CancelButtonWidget(),
                          SaveButtonWidget(onPressed: _submitExpenseData)
                        ],
                      )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class SaveButtonWidget extends StatelessWidget {
  final Function() onPressed;

  const SaveButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Save Expense'),
    );
  }
}

class CancelButtonWidget extends StatelessWidget {
  const CancelButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Cancel'),
    );
  }
}

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    required TextEditingController amountController,
  }) : _amountController = amountController;

  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixText: '\$',
        label: Text('Amount'),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: InputDecoration(label: Text('Title')),
    );
  }
}

class DatePickWidget extends StatelessWidget {
  const DatePickWidget({
    super.key,
    required this.onDateSelected,
  });

  final Function() onDateSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onDateSelected,
      icon: Icon(Icons.calendar_month),
    );
  }
}

class CategoryDropdownWidget extends StatelessWidget {
  final ExpenseCategory selectedCategory;
  final Function(ExpenseCategory) onExpenseCategoryChanged;

  const CategoryDropdownWidget({
    super.key,
    this.selectedCategory = ExpenseCategory.leisure,
    required this.onExpenseCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
      items: ExpenseCategory.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        onExpenseCategoryChanged(value);
      },
    );
  }
}

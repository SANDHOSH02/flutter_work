import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseManagerApp());
}

class ExpenseManagerApp extends StatelessWidget {
  const ExpenseManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalIncome = 0;
  int totalExpense = 0;

  final incomeController = TextEditingController();
  final expenseController = TextEditingController();

  void _addIncome(int amount) {
    setState(() {
      totalIncome += amount;
    });
  }

  void _addExpense(int amount) {
    setState(() {
      totalExpense += amount;
    });
  }

  void _resetAll() {
    setState(() {
      totalIncome = 0;
      totalExpense = 0;
    });
  }

  int get balance => totalIncome - totalExpense;

  @override
  void dispose() {
    incomeController.dispose();
    expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Expense Manager'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Total Income'),
                trailing: Text('₹$totalIncome'),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Total Expense'),
                trailing: Text('₹$totalExpense'),
              ),
            ),
            Card(
              color: Colors.teal[50],
              child: ListTile(
                title: const Text('Balance'),
                trailing: Text(
                  '₹$balance',
                  style: TextStyle(
                    color: balance >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Income Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                final income = int.tryParse(incomeController.text);
                if (income != null) {
                  _addIncome(income);
                  incomeController.clear();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Income'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: expenseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Expense Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                final expense = int.tryParse(expenseController.text);
                if (expense != null) {
                  _addExpense(expense);
                  expenseController.clear();
                }
              },
              icon: const Icon(Icons.remove),
              label: const Text('Add Expense'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _resetAll,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset All'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

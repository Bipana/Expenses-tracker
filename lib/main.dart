import 'package:expenses_tracker/models/Transaction.dart';
import 'package:expenses_tracker/widgets/chart.dart';
import 'package:expenses_tracker/widgets/new_transaction.dart';

import 'package:expenses_tracker/widgets/transaction_list.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpensePage(),
      title: "Expenses Tracker",
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.green,
        fontFamily: "Mont",
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: "Mont",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: "Lato",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Transaction> _usertransactions = [
//    Transaction(
//        itemName: "Groceries", itemPrice: 12.50, itemDate: DateTime.now()),
//    Transaction(itemName: "Watch", itemPrice: 60.50, itemDate: DateTime.now()),
//    Transaction(itemName: "Gown", itemPrice: 30.50, itemDate: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _usertransactions.where((tx) {
      return tx.itemDate.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txName, double txPrice, DateTime txDate) {
    final newTx =
        Transaction(itemName: txName, itemPrice: txPrice, itemDate: txDate);
    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _showAddTransaction(BuildContext bCtx) {
    showModalBottomSheet(
        context: bCtx,
        builder: (ctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Tracker"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showAddTransaction(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            Transactionlist(_usertransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _showAddTransaction(context);
        },
      ),
    );
  }
}

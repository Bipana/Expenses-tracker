import 'package:expenses_tracker/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text("No expense added yet",
                      style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: constraints.maxHeight * 0.03,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child:
                        Image.asset("assets/images/box.png", fit: BoxFit.cover),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 6,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CircleAvatar(
                      radius: 25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FittedBox(
                          child: Text(
                            '\$' + transactions[index].itemPrice.toString(),
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].itemName,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMEd().format(transactions[index].itemDate),
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[900],
                    ),
                    onPressed: () {
                      deleteTx(transactions[index].id);
                    },
                  ),
                ),
              );
            },
          );
  }
}

//Row(
//children: <Widget>[
//Container(
//child: Text(
//'\$' + transactions[index].itemPrice.toString(),
//style: TextStyle(
//color: Theme.of(context).accentColor,
//fontSize: 30.0,
//fontWeight: FontWeight.bold,
//),
//),
//decoration: BoxDecoration(
//border: Border.all(
//color: Theme.of(context).accentColor,
//width: 2,
//)),
//margin:
//EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//padding: EdgeInsets.all(5.0),
//),
//Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Text(
//transactions[index].itemName,
//style: Theme.of(context).textTheme.title,
//),
//Text(
//DateFormat.yMMMEd()
//.format(transactions[index].itemDate),
//style: TextStyle(
//fontSize: 15.0,
//color: Colors.grey,
//),
//),
//],
//)
//],
//),

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transation_model.dart';

class TransctionList extends StatelessWidget {
  final List<TransactionModel> userTransations;
  final Function deleteTransaction;
  TransctionList({this.userTransations, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: userTransations.length,
        itemBuilder: (context, index) {
          final trans = userTransations[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text(trans.amount.toString()),
                  ),
                ),
              ),
              title: Text(
                trans.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(trans.date),
              ),
              trailing: IconButton(
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
                onPressed: () => deleteTransaction(trans.id),
              ),
            ),
          );

          return Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${trans.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${trans.title}',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      DateFormat.yMMMd().format(trans.date),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

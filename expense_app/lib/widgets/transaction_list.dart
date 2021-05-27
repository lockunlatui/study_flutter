import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: transaction.map((tx) {
      return Card(
          child: Row(
        children: <Widget>[
          Container(
            child: Text(
              '\$${tx.amount}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple),
            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2)),
            padding: EdgeInsets.all(10),
          ),
          Column(
            children: <Widget>[
              Text(
                tx.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(tx.date),
                style: TextStyle(color: Colors.grey),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
      ));
    }).toList());
  }
}

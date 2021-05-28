import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        var recentTransactionDate = recentTransactions[i].date;

        if (recentTransactionDate.day == weekDay.day &&
            recentTransactionDate.month == weekDay.month &&
            recentTransactionDate.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, element) => sum += element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((groupTx) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    groupTx['day'],
                    groupTx['amount'],
                    totalSpending == 0.0
                        ? 0.0
                        : (groupTx['amount'] as double) / totalSpending));
          }).toList(),
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

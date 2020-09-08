import 'package:expense_planner/models/transation_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> resentTransaction;
  Chart(this.resentTransaction);

  List<Map<String, Object>> get groupTransationValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sumTotal = 0;
      for (var i = 0; i < resentTransaction.length; i++) {
        var item = resentTransaction[i];
        var itemDate = item.date;

        if (itemDate.day == weekDay.day &&
            itemDate.month == weekDay.month &&
            itemDate.year == weekDay.year) {
          sumTotal += item.amount;
        }
      }
      return {"day": DateFormat.E().format(weekDay), "amout": sumTotal};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransationValue.fold(0.0, (previousValue, element) {
      return previousValue + (element['amout'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupTransationValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data['day'].toString(),
                  amount: data['amout'],
                  amountPrecintge: totalSpending == 0.0
                      ? 0.0
                      : (data['amout'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}

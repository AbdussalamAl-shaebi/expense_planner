import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrasationMethod;
  NewTransaction({this.addTrasationMethod});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = new TextEditingController();
  final _amoutController = new TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amoutController.text.isEmpty) {
      return;
    }
    final amount = double.tryParse(_amoutController.text);
    final title = _titleController.text;

    if (title.isEmpty || (amount ?? 0) <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTrasationMethod(title, amount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    var nowDate = DateTime.now();
    showDatePicker(
            context: context,
            initialDate: nowDate,
            firstDate: DateTime(nowDate.year),
            lastDate: nowDate)
        .then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tilte',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amoutController,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen'
                          : 'Date ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Chose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transation'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}

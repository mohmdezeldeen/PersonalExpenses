import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionFn;

  NewTransaction(this.addTransactionFn);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredamount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredamount <= 0 || _selectedDate == null)
      return;

    widget.addTransactionFn(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
//    Platform.isIOS
//        ? showCupertinoModalPopup(
//            context: context,
//            builder: (context) => Column(
////              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                CupertinoDatePicker(
//                    mode: CupertinoDatePickerMode.date,
//                    onDateTimeChanged: (date) {
//                      if (date == null) return;
//                      setState(() {
//                        _selectedDate = date;
//                      });
//                    },
//                    initialDateTime: DateTime.now(),
//                    minimumDate: DateTime(2019),
//                    maximumDate: DateTime.now()),
//                CupertinoButton(
//                  onPressed: () => Navigator.pop(context),
//                  child: Text(
//                    'Done',
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                ),
//              ],
//            ),
//          )
//        :
    showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime.now())
            .then((date) {
            if (date == null) return;
            setState(() {
              _selectedDate = date;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            MediaQuery.of(context).viewInsets.bottom + 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Title',
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                    )
                  : TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                    ),
              Platform.isIOS
                  ? CupertinoTextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      placeholder: 'Amount',
                      controller: _amountController,
                      onSubmitted: (_) => _submitData(),
                    )
                  : TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: _amountController,
                      onSubmitted: (_) => _submitData(),
                    ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date '
                              'Chosen!'
                          : 'Picked Date ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    AdaptiveFlatButton(
                      'Choose Date',
                      _presentDatePicker,
                    ),
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                      onPressed: _submitData,
                    )
                  : RaisedButton(
                      child: Text('Add Transaction'),
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

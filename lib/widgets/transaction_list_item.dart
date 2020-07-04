import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionListItem extends StatefulWidget {
  const TransactionListItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionListItemState createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  Color _bgColor;

  @override
  void initState() {
    super.initState();
    const availableColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple
    ];
    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: widget.key,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FittedBox(child: Text('\$${widget.transaction.amount}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('DELETE'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}

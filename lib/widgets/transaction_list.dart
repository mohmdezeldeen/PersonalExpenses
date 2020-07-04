import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/transaction_list_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return TransactionListItem(
                key: ValueKey(transactions[index].id),
                transaction: transactions[index],
                deleteTx: deleteTx,
              );
            },
          );
  }
}

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList()');
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      height: constraints.maxHeight * .6,
                      child: Image.asset(
                        'lib/assets/images/wallet.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              var padding2 = Padding(
                padding: const EdgeInsets.all(15.0),
                child: TransactionItem(transaction: transactions[index], deleteTx: deleteTx),
              );
              return padding2;
            },
            itemCount: transactions.length,
          );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:third_app/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('createState NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdateWidget()');

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('initState()');
    super.dispose();
  }

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    Platform.isIOS
        ? showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).copyWith().size.height / 2.5,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      // initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime pickedDate) {
                        if (pickedDate == null) {
                          setState(() {
                            _selectedDate = DateTime.now();
                            print(_selectedDate);
                          });
                        }
                        setState(
                          () {
                            _selectedDate = pickedDate;
                            print(_selectedDate);
                          },
                        );
                      },
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Select',
                      style: Theme.of(context).textTheme.button,
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).copyWith().size.height / 10,
                  )
                ],
              );
            },
          )
        : showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now(),
          ).then((pickedDate) {
            if (pickedDate == null) {
              return;
            }
            setState(() {
              _selectedDate = pickedDate;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Title',
                      controller: _titleController,
                    )
                  : TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Amount',
                      controller: _amountController,
                    )
                  : TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => submitData,
                    ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                child: Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.button,
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}

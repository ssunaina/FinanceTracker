import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: Theme.of(context).textTheme.subtitle,
            ),
            onPressed: handler,
          )
        : FlatButton(
            child: Text(
              text,
              style: Theme.of(context).textTheme.subtitle,
            ),
            onPressed: handler,
          );
  }
}  

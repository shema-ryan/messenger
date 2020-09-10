import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String _message;
  MessageWidget(this._message);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.brown,
          ),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            _message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

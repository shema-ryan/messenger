import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String _message;
  final bool _isMe;
  final Key key;
  final String _userName;
  MessageWidget(this._message, this._isMe, this._userName, {this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: !_isMe ? Radius.circular(10) : Radius.circular(0),
              topLeft: !_isMe ? Radius.circular(0) : Radius.circular(10),
            ),
            color: _isMe ? Colors.grey[400] : Colors.brown[200],
          ),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_isMe)
                Text(
                  _userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              if (!_isMe) Divider(),
              Text(
                _message,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

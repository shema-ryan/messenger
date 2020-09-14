import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextFieldMessage extends StatefulWidget {
  @override
  _TextFieldMessageState createState() => _TextFieldMessageState();
}

class _TextFieldMessageState extends State<TextFieldMessage> {
  // Helper functions
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('Chat').add({
      'text': message,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()['username'],
      'image_url': userData.data()['image_url'],
    });
    _controller.clear();
  }

  // Helper variables
  String message = '';
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      // padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            cursorColor: Theme.of(context).accentColor,
            onChanged: (String text) {
              setState(() {
                message = text;
              });
            },
            decoration: InputDecoration(
                filled: true,
                hintText: 'send a message ...',
                border: InputBorder.none),
          )),
          IconButton(
              icon: Icon(
                Icons.send,
                color: message.trim().isEmpty
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
              ),
              onPressed: message.trim().isEmpty ? null : _sendMessage),
        ],
      ),
    );
  }
}

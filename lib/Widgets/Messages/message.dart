import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Widgets/Messages/messageWidget.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('/Chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snap.data.docs;
        return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (BuildContext context, int index) =>
                MessageWidget(docs[index].data()['text']));
      },
    );
  }
}

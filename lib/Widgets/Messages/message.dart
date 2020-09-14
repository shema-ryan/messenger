import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Widgets/Messages/messageWidget.dart';
import 'dart:math';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
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
          itemBuilder: (BuildContext context, int index) => MessageWidget(
            docs[index].data()['text'],
            docs[index].data()['userId'] == user.uid,
            docs[index].data()['userName'],
            docs[index].data()['image_url'],
            key: ValueKey(Random().nextInt(5).toString()),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Messenger'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/Chats/jmTvuPJxvAdOZkrSosJV/Messages')
              .snapshots()
              .listen((data) {
            print(data);
          });
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) => Container(
                padding: const EdgeInsets.all(10.0),
                child: Text('app texting'),
              )),
    );
  }
}

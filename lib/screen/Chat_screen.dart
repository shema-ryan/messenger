import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

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
                .add({'Text': 'another message'});
//            await Firebase.initializeApp();
//              .listen((data) {
//            print(data.docs[0].data()['Text']);
//          });
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('/Chats/jmTvuPJxvAdOZkrSosJV/Messages')
              .snapshots(),
          builder: (BuildContext context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = snap.data.docs;
            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) => Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(docs[index].data()['Text']),
                    ));
          },
        ));
  }
}

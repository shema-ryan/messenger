import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Messenger'),
          actions: [
            DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Log out',
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Log Out'),
                        ],
                      ),
                    ),
                  )
                ],
                onChanged: (value) {
                  if (value == 'Log out') {
                    FirebaseAuth.instance.signOut();
                  }
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('/Chats/jmTvuPJxvAdOZkrSosJV/Messages')
                .add({'Text': 'am good'});
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('/Chats/jmTvuPJxvAdOZkrSosJV/Messages')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = snap.data.docs;
            print(docs);
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

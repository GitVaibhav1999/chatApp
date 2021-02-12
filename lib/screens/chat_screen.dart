import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/LawBndU2ROOz8VGE1WI1/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            final documents = streamSnapshot.data.docs;

            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(10),
                child: Text(documents[index]['text']),
              ),
              itemCount: documents.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/LawBndU2ROOz8VGE1WI1/messages')
              .add({
            'text': 'this was added by button',
            'name': 'vaibhav',
          });
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 1.2,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical:2, horizontal: 10),
                child: Card(
                  elevation: 20,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.account_circle),
                    ),
                    title: Text(snapshot.data.documents[index].data['name']),
                    subtitle: Text(snapshot.data.documents[index].data['score']
                        .toString()),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: snapshot.data.documents.length,
          ),
        );
      },
      stream: Firestore.instance
          .collection('profiles')
          .orderBy('score', descending: true)
          .limit(10)
          .snapshots(),
    );
  }
}

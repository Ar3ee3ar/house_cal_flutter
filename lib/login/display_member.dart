import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class memberMange extends StatefulWidget {
  @override
  _memberPage createState() {
    return _memberPage();
  }
}

class _memberPage extends State<memberMange>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("จัดการสมาชิก"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('member').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView(
            children: snapshot.data!.docs.map((document){
              return Container(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text(document["role"]),
                    )
                  ),
                  title: Text(document["username"]),
                  subtitle: Text(document["password"]),
                ),
              );
            }).toList(),
          );
        },
      )
    );
  }

}

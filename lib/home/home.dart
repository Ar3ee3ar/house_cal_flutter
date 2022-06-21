import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/profile.dart';

class Home extends StatefulWidget{
  @override
  _Homepage createState() {
    return _Homepage();
  }

}

class _Homepage extends State<Home>{

  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();

  // CollectionReference _memberCollections = FirebaseFirestore.instance.collection("member");

  @override
  Widget build(BuildContext context) {
    return(Text("test"));
  }

}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cal/login/login_page.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../calculator/cal_page.dart';
import '../model/profile.dart';

class regis extends StatefulWidget {
  @override
  _regisPage createState() {
    return _regisPage();
  }
}

class _regisPage extends State<regis> {

  final formKey = GlobalKey<FormState>();
  bool haveUser = false;

  Profile profile = Profile();
  // เตรียม firebase
  // final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _memberCollections = FirebaseFirestore.instance.collection("member");
  DocumentReference ref = FirebaseFirestore.instance.collection("role").doc('1');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Scaffold(
            appBar: AppBar(title: Text("error"),),
            body: Center(child: Text("${snapshot.error}"),),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return Scaffold(
              appBar: AppBar(
                title: const Text('สมัครสมาชิก'),
              ),
              body: Stack(
                    children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 35,
                          left: 35,
                          right: 35,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            TextFormField(
                              // controller: roomCost,
                              validator: RequiredValidator(errorText: "กรุณากรอกชื่อผู้ใช้"),
                              onSaved: (String? username) => profile.username = username,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'username',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: TextFormField(
                                    // controller: oldUnit,
                                    validator: RequiredValidator(
                                        errorText: "กรุณากรอกรหัสผ่าน"),
                                    onSaved: (String? password) =>
                                        profile.password = password,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'password',
                                      labelStyle: TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            ElevatedButton(
                              child: const Text('สมัคร'),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  _memberCollections.doc(profile.username).get().then(
                                    (DocumentSnapshot documentSnapshot) async {
                                      if(documentSnapshot.exists){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('มีชื่อผู้ใช้นี้อยู่ในระบบแล้ว')),);
                                      }
                                      else{
                                        formKey.currentState!.save();
                                        await _memberCollections.doc(profile.username).set({
                                          "password": profile.password,
                                          "role": ref
                                        });
                                        haveUser = false;
                                        formKey.currentState!.reset();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => login()),
                                        );
                                      }
                                    }
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator(),),
        );
      }
    );
  }
}

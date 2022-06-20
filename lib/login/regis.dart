import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  Profile profile = Profile();
  // เตรียม firebase
  // final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _memberCollections = FirebaseFirestore.instance.collection("member");

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
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await _memberCollections.add({
                                    "username": profile.username,
                                    "password": profile.password,
                                    "role": "admin"
                                  });
                                  formKey.currentState!.reset();
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FirstScreen()),
                                );
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

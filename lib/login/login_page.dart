import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../calculator/cal_page.dart';
import '../login/regis.dart';
import '../model/profile.dart';

import '../login/display_member.dart';



class login extends StatefulWidget {
  @override
  _loginPage createState() {
    return _loginPage();
  }
}

class _loginPage extends State<login> {

  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();

  CollectionReference _memberCollections = FirebaseFirestore.instance.collection("member");
  // CollectionReference _roleCollections = FirebaseFirestore.instance.collection("role");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('member').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('เข้าสู่ระบบ'),
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
                            validator: RequiredValidator(
                                errorText: "กรุณากรอกชื่อผู้ใช้"),
                            keyboardType: TextInputType.text,
                            onSaved: (String? username) =>
                                profile.username = username,
                            decoration: InputDecoration(
                              labelText: 'username',
                              labelStyle: TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          TextFormField(
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
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: ElevatedButton(
                                  child: const Text('เข้าสู่ระบบ'),
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      formKey.currentState!.save();
                                      _memberCollections.doc(profile.username).get().then(
                                        (DocumentSnapshot documentSnapshot) async{
                                          // print(profile.username);
                                          if(documentSnapshot.exists) {
                                            Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
                                            if(profile.password == data['password']) {
                                              DocumentReference roleRef =  FirebaseFirestore.instance.doc(data['role'].toString());
                                              var DocSplit = data['role'].toString().split("(");
                                              var useDoc = DocSplit[DocSplit.length-1].split("/");
                                              var roleDoc = useDoc[0];
                                              var roleNum = useDoc[1].substring(0,useDoc[1].length-1);

                                              final ref = FirebaseFirestore.instance.collection("role");
                                              final roleSnapshot = await ref.doc(roleNum).get();
                                              if (roleSnapshot.exists) {
                                                Map<String, dynamic> roleData = roleSnapshot.data() as Map<String, dynamic>;
                                                if (roleData['name'] == "admin") {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                      FirstScreen()
                                                    ),
                                                  );
                                                }
                                                else{
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('คุณไม่มีสิทธ์เข้าถึงระบบส่วนนี้')),);
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('สิทธิ์การใช้งานผิดพลาด')),);
                                              }
                                            }
                                            else{
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('รหัสผ่านไม่ถูกต้อง')),);
                                            }
                                          }
                                          else{
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ไม่พบชื่อผู้ใช้ในระบบ')),);
                                          }
                                        }
                                      );
                                      // else{
                                      //   formKey.currentState!.save();
                                      //   await _memberCollections.doc(profile.username).set({
                                      //     "password": profile.password,
                                      //     "role": "admin"
                                      //   });
                                      //   formKey.currentState!.reset();
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => login()),
                                      //   );
                                      // }
                                    // if (formKey.currentState!.validate()) {
                                    //   formKey.currentState!.save();
                                    //   print("${profile.getUsername()}");
                                    //   formKey.currentState!.reset();
                                    // }
                                    }
                                  },
                                ),
                              ),
                              Flexible(
                                child: ElevatedButton(
                                  child: const Text('สมัครสมาชิก'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => regis()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

}
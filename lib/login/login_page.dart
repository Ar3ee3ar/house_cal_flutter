import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../calculator/cal_page.dart';
import '../login/regis.dart';
import '../model/profile.dart';


class login extends StatefulWidget {
  @override
  _loginPage createState() {
    return _loginPage();
  }
}

class _loginPage extends State<login> {

  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  @override
  Widget build(BuildContext context) {
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
                      validator: RequiredValidator(errorText: "กรุณากรอกชื่อผู้ใช้"),
                      keyboardType: TextInputType.text,
                      onSaved: (String? username) => profile.username = username,
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
                      validator: RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                      onSaved: (String? password) =>profile.password = password,
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
                                print("${profile.getUsername()}");
                                formKey.currentState!.reset();
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => FirstScreen()),
                              // );
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
                ),),
              ),
            ),
          ],
            )
          );
  }

}
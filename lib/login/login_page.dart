import 'package:flutter/material.dart';
import '../calculator/cal_page.dart';


class login extends StatefulWidget {
  @override
  _loginPage createState() {
    return _loginPage();
  }
}

class _loginPage extends State<login> {
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
              child: Column(
                children: <Widget>[
                SizedBox(height: 30.0),
                TextField(
                  // controller: roomCost,
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
                      child: TextField(
                        // controller: oldUnit,
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
                    child: const Text('เข้าสู่ระบบ'),
                    onPressed: () {
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
          ],
        ),
    );

  }

}
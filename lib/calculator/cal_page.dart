import 'package:flutter/material.dart';
import '../report/report_page.dart';
import '../model/profile.dart';


class FirstScreen extends StatefulWidget {
  @override
  FirstRoute createState() {
    return FirstRoute();
  }
}

class FirstRoute extends State<FirstScreen> {
  bool isCheck = false;
  TextEditingController oldUnit = TextEditingController();
  TextEditingController newUnit = TextEditingController();
  final perUnit = TextEditingController(text: "5");
  final water = TextEditingController(text: "80");
  final count = TextEditingController(text: "1");
  final trash = TextEditingController(text: "0");
  final roomCost = TextEditingController(text: "1500");

  // Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ค่าบ้าน'),
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
              child: Column(children: <Widget>[
                SizedBox(height: 30.0),
                TextField(
                  controller: roomCost,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ค่าห้อง',
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
                        controller: oldUnit,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'ยูนิตเก่า',
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: newUnit,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'ยูนิตใหม่',
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30.0),
                TextField(
                  controller: perUnit,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ราคาค่าไฟต่อหน่วย',
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
                        controller: water,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'ค่าน้ำ',
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: count,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'จำนวนคนอยู่',
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Checkbox(
                        value: isCheck,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheck = value!;
                            if (isCheck == false) {
                              trash.text = "0";
                            } else {
                              trash.text = "20";
                            }
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: trash,
                        // initialValue: "5",
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'ค่าขยะ',
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  child: const Text('คิดเลข'),
                  onPressed: () {
                    _sendDataToSecondScreen(context);
                  },
                ),
              ]),
             ),
            ),
        ],
      ),
    );
  }

  // get the text in the TextField and start the Second Screen
  void _sendDataToSecondScreen(BuildContext context) {
    int int_oldUnit = int.parse(oldUnit.text);
    int int_newUnit = int.parse(newUnit.text);
    int int_perUnit = int.parse(perUnit.text);
    int int_water = int.parse(water.text);
    int int_trash = int.parse(trash.text);
    int int_count = int.parse(count.text);
    int int_roomCount = int.parse(roomCost.text);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SecondRoute(
                oldUnit: int_oldUnit,
                newUnit: int_newUnit,
                perUnit: int_perUnit,
                count: int_count,
                trash: int_trash,
                water: int_water,
                roomCost: int_roomCount,
              )),
    );
  }
}
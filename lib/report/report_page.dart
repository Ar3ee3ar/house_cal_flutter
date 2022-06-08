import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  int oldUnit;
  int newUnit;
  int water;
  int count;
  int perUnit;
  int trash;
  int roomCost;
  SecondRoute({Key? key, required this.oldUnit, required this.newUnit, required this.perUnit, required this.water, required this.count, required this.trash, required this.roomCost}) : super(key: key);
  // SecondRoute({Key? key, required this.oldUnit, required this.newUnit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text('บิลเงินสด'),
        ),
      ),
      body:
      ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: const Text('ค่าห้อง')),
              Flexible(child: Text(roomCost.toString())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: const Text('ค่าน้ำ')),
              Flexible(child: Text((water * count).toString())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: const Text(
                  'ยูนิตที่ใช้'
                )
              ),
              Flexible(
                child: Text(
                  (newUnit - oldUnit).toString() + ' x ' + perUnit.toString()
                )
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: const Text('ค่าไฟ')),
              Flexible(
                  child: Text(((newUnit - oldUnit)*5).toString())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: const Text('ค่าขยะ')),
              Flexible(
                  child: Text(trash.toString())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: const Text('รวม')),
              Flexible(
                  child: Text((roomCost + (water * count) + ((newUnit - oldUnit)*5) + trash).toString())),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back'),
          ),
        ],
      ),
    );
  }
}
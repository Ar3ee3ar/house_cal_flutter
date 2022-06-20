import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'calculator/cal_page.dart';
import 'report/report_page.dart';
import 'login/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Rent app',
    home: login(),
  ));
}


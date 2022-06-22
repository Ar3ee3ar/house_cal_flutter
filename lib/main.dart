import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'calculator/cal_page.dart';
import 'report/report_page.dart';
import 'login/login_page.dart';
import 'key/keyapi.dart';

void main() async{
  keyAPI key = keyAPI();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: key.apiKey,
      appId: key.appId,
      messagingSenderId: key.messagingSenderId,
      projectId: key.projectId,
    ),
  );
  runApp(MaterialApp(
    title: 'Rent app',
    home: login(),
  ));
}


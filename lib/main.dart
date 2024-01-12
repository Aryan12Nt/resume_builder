import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resume_builder/screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: ResumeScreen(),
    );
  }
}
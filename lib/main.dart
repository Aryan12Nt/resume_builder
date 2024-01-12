import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resume_builder/resume_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp( MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: ResumeScreen(),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/model.dart';

class ResumeDetailsScreen extends StatelessWidget {
  final ResumeItem resumeItem;

  const ResumeDetailsScreen({Key? key, required this.resumeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${resumeItem.title ?? ""}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Email: ${resumeItem.email ?? ""}'),
            Text('Phone Number: ${resumeItem.phoneNumber ?? ""}'),
            Text('Address: ${resumeItem.address ?? ""}'),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('${resumeItem.description ?? ""}'),
          ],
        ),
      ),
    );
  }
}
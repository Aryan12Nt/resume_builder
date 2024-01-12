import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResumeDetails extends StatelessWidget {
  final String email;
  final bool isEditScreen;
  final String phoneNumber;
  final String docId;
  final String name;
  final String description;
  final String address;
  final String skills;
  final String? edutcation;
  final String? experiance;
  final String? position;

  ResumeDetails({
    required this.email,
    required this.isEditScreen,
    required this.phoneNumber,
    required this.docId,
    required this.name,
    required this.description,
    required this.address,
    required this.skills,
    required this.edutcation,
    required this.position,
    required this.experiance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Details'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldCard('Name', name),
            _buildFieldCard('Description', description),
            _buildFieldCard('Address', address),
            _buildFieldCard('Skills', skills),
            _buildFieldCard('Email', email),
            _buildFieldCard('Phone Number', phoneNumber),
            _buildFieldCard('Education', edutcation ?? ""),
            _buildFieldCard('Position', position ?? " "),
            _buildFieldCard('Experiance', experiance ?? " "),
            SizedBox(height: 16.0),
            if (isEditScreen)
              ElevatedButton(
                onPressed: () {
                },
                child: Text('Edit'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldCard(String label, String value) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label: ',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0.sp),
            Text(
              value,
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}

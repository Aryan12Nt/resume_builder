import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/model.dart';

class ResumeForm extends StatefulWidget {
  final ResumeItem? resumeItem;

  ResumeForm({this.resumeItem});

  @override
  _ResumeFormState createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  TextEditingController? titleController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? addressController;
  TextEditingController? descriptionController;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.resumeItem?.title ?? '');
    emailController =
        TextEditingController(text: widget.resumeItem?.email ?? '');
    phoneController =
        TextEditingController(text: widget.resumeItem?.phoneNumber ?? '');
    addressController =
        TextEditingController(text: widget.resumeItem?.address ?? '');
    descriptionController =
        TextEditingController(text: widget.resumeItem?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resumeItem == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveResumeItem();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveResumeItem() async {
    final CollectionReference resumeCollection =
    FirebaseFirestore.instance.collection('resumes');
    final title = titleController?.text;
    final email = emailController?.text;
    final phone = phoneController?.text;
    final address = addressController?.text;
    final description = descriptionController?.text;

    if (title != null &&
        description != null &&
        title.isNotEmpty &&
        description.isNotEmpty) {
      final result = ResumeItem(
        title: title,
        email: email,
        phoneNumber: phone,
        address: address,
        description: description,
      );

      // Add new resume item to Firestore
      await resumeCollection.add({
        'title': result.title,
        'email': result.email,
        'phoneNumber': result.phoneNumber,
        'address': result.address,
        'description': result.description,
      });

      Navigator.pop(context, result);
    }
  }
}
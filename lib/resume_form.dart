import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/model.dart';
class ResumeForm extends StatefulWidget {
  bool isEditScreen;
  final ResumeItem? resumeItem;
  final String? docId;
  final String? title;
  final String? description;
  final String? address;
  final String? skills;
  final String? email;
  final String? phoneNumber;

  ResumeForm(
      {this.docId,this.email,this.phoneNumber,
        this.isEditScreen = false,
        this.title,
        this.description,
        this.address,
        this.skills,
        this.resumeItem});

  @override
  _ResumeFormState createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  TextEditingController? titleController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? addressController;
  TextEditingController? descriptionController;
  TextEditingController? skillsController;

  @override
  void initState() {
    super.initState();
    initilizeController(); // Call the initialization method here
  }

  void initilizeController() {
    if (widget.isEditScreen) {
      skillsController = TextEditingController(text: widget.skills);
      titleController = TextEditingController(text: widget.title);
      emailController = TextEditingController(text: widget.email);
      phoneController =
          TextEditingController(text: widget.phoneNumber);
      addressController =
          TextEditingController(text: widget.address);
      descriptionController =
          TextEditingController(text: widget.description);
    }
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
            TextField(
              controller: skillsController,
              decoration: InputDecoration(labelText: 'Skill'),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveResumeItem();
              },
              child: Text(widget.isEditScreen ? 'edit' : "save"),
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
    final skills = skillsController?.text;

    if (title != null &&
        description != null &&
        title.isNotEmpty &&
        description.isNotEmpty) {
      final result = ResumeItem(
        skills: skills,
        title: title,
        email: email,
        phoneNumber: phone,
        address: address,
        description: description,
      );

      if (widget.isEditScreen) {
        // Update the existing document using the provided docId
        await resumeCollection.doc(widget.docId).update({
          "skills": result.skills,
          'title': result.title,
          'email': result.email,
          'phoneNumber': result.phoneNumber,
          'address': result.address,
          'description': result.description,
        });
      } else {
        // Add new resume item to Firestore
        await resumeCollection.add({
          "skills": result.skills,
          'title': result.title,
          'email': result.email,
          'phoneNumber': result.phoneNumber,
          'address': result.address,
          'description': result.description,
        });
      }

      Navigator.pop(context, result);
    }
  }
}
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
  final String? edutcation;
  final String? experiance;
  final String? position;

  ResumeForm({
    this.docId,
    this.email,
    this.phoneNumber,
    this.isEditScreen = false,
    this.title,
    this.description,
    this.address,
    this.skills,
    this.resumeItem,
    this.position,
    this.edutcation,
    this.experiance,
  });

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
  TextEditingController? positionController;
  TextEditingController? educationController;
  TextEditingController? experianceController;

  @override
  void initState() {
    super.initState();
    initilizeController(); // Call the initialization method here
  }

  void initilizeController() {
    skillsController = TextEditingController(text: widget.skills);
    titleController = TextEditingController(text: widget.title);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phoneNumber);
    addressController = TextEditingController(text: widget.address);
    descriptionController = TextEditingController(text: widget.description);
    positionController = TextEditingController(text: widget.position);
    educationController = TextEditingController(text: widget.edutcation);
    experianceController = TextEditingController(text: widget.experiance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.isEditScreen== false ? 'Add Item' : 'Edit Item'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: positionController,
                  decoration: InputDecoration(labelText: 'Position'),
                ),
                TextField(
                  controller: educationController,
                  decoration: InputDecoration(labelText: 'Education'),
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
                  controller: experianceController,
                  decoration: InputDecoration(labelText: 'Experiance'),
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
        ));
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
    final position = positionController?.text;
    final experience = experianceController?.text;
    final education = educationController?.text;

    final result = ResumeItem(
      title: title,
      email: email,
      phoneNumber: phone,
      address: address,
      description: description,
      skills: skills,
      position: position,
      experience: experience,
      education: education,
    );

    if (widget.isEditScreen) {
      await resumeCollection.doc(widget.docId).update({
        "title": result.title,
        'email': result.email,
        'phoneNumber': result.phoneNumber,
        'address': result.address,
        'description': result.description,
        'skills': result.skills,
        'position': result.position,
        'experience': result.experience,
        'education': result.education,
      });
    } else {
      await resumeCollection.add({
        "title": result.title,
        'email': result.email,
        'phoneNumber': result.phoneNumber,
        'address': result.address,
        'description': result.description,
        'skills': result.skills,
        'position': result.position,
        'experience': result.experience,
        'education': result.education,
      });
    }

    Navigator.pop(context, result);
  }
}

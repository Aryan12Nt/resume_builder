import 'package:flutter/material.dart';
import 'package:resume_builder/model.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  List<ResumeItem> resumeItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume App'),
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          _reorderResumeItems(oldIndex, newIndex);
        },
        children: _buildResumeItems(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToResumeForm();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildResumeItems() {
    return resumeItems
        .asMap()
        .map((index, item) {
      return MapEntry(
        index,
        Card(
          key: ValueKey(item),
          margin: EdgeInsets.all(8.0),
          elevation: 4.0,
          child: ListTile(
            title: Text(item.title!),
            subtitle: Text(item.description!),
            onTap: () {
              _navigateToResumeForm();
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteResumeItem(index);
              },
            ),
          ),
        ),
      );
    })
        .values
        .toList();
  }

  void _navigateToResumeForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeForm(),
      ),
    );
  }

  void _deleteResumeItem(int index) {
    setState(() {
      resumeItems.removeAt(index);
    });
  }

  void _reorderResumeItems(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = resumeItems.removeAt(oldIndex);
      resumeItems.insert(newIndex, item);
    });
  }
}

class ResumeForm extends StatefulWidget {
  ResumeForm({super.key});

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
    titleController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
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

  void _saveResumeItem() {
    final title = titleController?.text;
    final email = emailController?.text;
    final phone = phoneController?.text;
    final address = addressController?.text;
    final description = descriptionController?.text;

    if (title != null &&
        description != null &&
        title.isNotEmpty &&
        description.isNotEmpty) {
      Navigator.pop(
        context,
        ResumeItem(
          title: title,
          email: email,
          phoneNumber: phone,
          address: address,
          description: description,
        ),
      );
    } else {}
  }
}
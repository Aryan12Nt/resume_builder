import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/model.dart';
import 'package:resume_builder/resume_form.dart';

class ResumeScreen extends StatefulWidget {
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final CollectionReference resumeCollection =
  FirebaseFirestore.instance.collection('resume');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume App'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('resumes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (streamSnapshot.hasData &&
              streamSnapshot.data.docs.isNotEmpty) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: streamSnapshot.data.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(streamSnapshot.data.docs[index]["title"]),
                  onTap: () {
                    // Handle item tap if needed
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteResumeItem(streamSnapshot.data.docs[index].id);
                    },
                  ),
                );
              },
            );
          } else if (streamSnapshot.hasError) {
            debugPrint("Error: ${streamSnapshot.error}");
          }
          return Center(child: Text("No data available."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToResumeForm();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToResumeForm({ResumeItem? resumeItem}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeForm(),
      ),
    );
  }

  void _deleteResumeItem(String id) async {
    await resumeCollection.doc(id).delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/resume_form.dart';

class ResumeScreen extends StatefulWidget {
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final CollectionReference resumeCollection =
  FirebaseFirestore.instance.collection('resumes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume App'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('resumes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
          if (streamSnapshot.hasData) {
            List<DocumentSnapshot> resumeDocs = streamSnapshot.data.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: resumeDocs.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " Name: ${resumeDocs[index]["title"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              " Description: ${resumeDocs[index]["description"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " Address: ${resumeDocs[index]["address"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " Skills: ${resumeDocs[index]["skills"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteResumeItem(resumeDocs[index].id);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          } else if (streamSnapshot.hasError) {
            debugPrint("Error: ${streamSnapshot.error}");
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ResumeForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToResumeForm(DocumentSnapshot resumeDoc) async {
    debugPrint("Document ID: ${resumeDoc.id}");
    debugPrint("Title: ${resumeDoc["title"]}");
    debugPrint("Description: ${resumeDoc["description"]}");
    debugPrint("Address: ${resumeDoc["address"]}");
    debugPrint("Skills: ${resumeDoc["skills"]}");

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeForm(
          email: resumeDoc["email"],
          isEditScreen: true,
          phoneNumber: resumeDoc["phoneNumber"],
          docId: resumeDoc.id,
          title: resumeDoc["title"],
          description: resumeDoc["description"],
          address: resumeDoc["address"],
          skills: resumeDoc["skills"],
        ),
      ),
    );
  }

  void _deleteResumeItem(String id) async {
    try {
      await resumeCollection.doc(id).delete();
      debugPrint("Deleted document with ID: $id");
    } catch (e) {
      debugPrint("Error deleting document: $e");
    }
  }
}
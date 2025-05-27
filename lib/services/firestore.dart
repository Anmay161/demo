import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {  
  
  final CollectionReference notes = FirebaseFirestore.instance.collection("notes");

  // Add
  Future<void> addNote(String data) {
    return notes.add(
      {
        'note': data,
        'timestamp': Timestamp.now()
      }
    );
  }

  // Read
  Stream<QuerySnapshot> getStream() {
    final notesStream = notes.orderBy('timestamp',descending: true).snapshots();
    return notesStream;
  }

  // Update
  Future<void> updateNote(docID, data) {
    return notes.doc(docID).update({
      'note': data,
      'timestamp': Timestamp.now()
    });
  }


  // Delete
  Future<void> deleteNote(docID) {
    return notes.doc(docID).delete();
  }


  void openNote(String? docID,context,getinput) {
      showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: getinput),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (docID == null) {
                    addNote(getinput.text);
                  }
                  else {
                    updateNote(docID, getinput.text);
                  }
                  getinput.clear();
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }
}
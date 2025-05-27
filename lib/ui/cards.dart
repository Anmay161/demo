import 'package:demo/services/firestore.dart';
import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final FirestoreServices firestoreServices = FirestoreServices();


  final String noteText;
  final String docID;
  final BuildContext context;
  final TextEditingController getinput;
  Cards ({
    super.key,
    required this.noteText,
    required this.docID,
    required this.context,
    required this.getinput
  });

  @override
  Widget build(BuildContext context) {
          return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Row(
                      children: [
                        // Expanded text section
                        Expanded(
                          child: Text(
                            noteText,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),

                        // Action icons
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => firestoreServices.openNote(docID,context,getinput),
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                              tooltip: 'Edit',
                            ),
                            IconButton(
                              onPressed: () => firestoreServices.deleteNote(docID),
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              tooltip: 'Delete',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
  }

}
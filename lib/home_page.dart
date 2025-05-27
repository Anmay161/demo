
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/firestore.dart';
import 'package:demo/ui/cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  FirestoreServices firestoreServices = FirestoreServices();

  
  TextEditingController getinput = TextEditingController();

  


  void signedOut() async{
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        actions: [
          IconButton(
            onPressed: signedOut, 
            icon: Icon(Icons.logout),
            tooltip: "Log out",
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreServices.getStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            if (notesList.isEmpty) {
              return Text("There is no notes");
            }

            return ListView.builder(
              itemCount: notesList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                DocumentSnapshot docs = notesList[index];
                String docID = docs.id;

                Map<String, dynamic> data = docs.data() as Map<String, dynamic>;
                String noteText = data['note'];
                return Cards(noteText: noteText,docID: docID,context: context,getinput: getinput,);
              },
            );

          }
          else {
            return Text("Something went wrong");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firestoreServices.openNote(null, context, getinput);
        },
        tooltip: "Add",
        child: Icon(Icons.add),
      ),
    );
  }
}

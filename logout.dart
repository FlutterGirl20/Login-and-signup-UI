import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen/getUser.dart';
import 'package:intro_screen/screens.dart/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User = FirebaseAuth.instance.currentUser!;
  List<String> docId = [];
  Future getdocId() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docId.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: CircleAvatar(
              maxRadius: 60,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
          ),
            Expanded(
              child: FutureBuilder(
            future: getdocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: docId.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GetUser(documentId: docId[index]),
                  );
                },
              );
            },
          )),
          Text(
            'signed in as:' + User.email!,
            style: TextStyle(fontSize: 20),
          ),
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            color: Color.fromARGB(255, 109, 83, 74),
            child: Text(
              'Sign Out',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        
        ],
      ),
    ));
  }
}

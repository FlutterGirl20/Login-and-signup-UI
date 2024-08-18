import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intro_screen/screens.dart/logout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPassVisible = true;
  final usercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  Future addData(String UserName, String Email, String password) async {
    if (UserName == "" && Email == "" && password == "") {
      Fluttertoast.showToast(msg: 'Enter Required Fields');
    } else {
      FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).set({
        'User': UserName,
        'Email': Email,
        'password': password,
        'UserId': currentUser!.uid
      }).then((value) {
        Fluttertoast.showToast(msg: 'Data Inserted');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: 900,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://marketplace.canva.com/EAF0h6mNol8/1/0/900w/canva-brown-minimalist-abstract-instagram-story-Tp-46MmIXZc.jpg'),
                fit: BoxFit.cover)),
        child: Center(
            child: SingleChildScrollView(
                child: Column(children: [
          Icon(
            Icons.person_2_sharp,
            size: 100,
          ),
          Text(
            'Signup to continue',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          ListTile(
            title: Text(
              'User Name:',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: TextFormField(
              controller: usercontroller,
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 232, 126, 91),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 232, 126, 91), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter your Name',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  prefixIcon: Icon(Icons.person, color: Colors.black)),
            ),
          ),
          ListTile(
            title: Text(
              'E-mail:',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: TextFormField(
              controller: emailcontroller,
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 232, 126, 91),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 232, 126, 91), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Enter your Email',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  prefixIcon: Icon(Icons.mail, color: Colors.black)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              ListTile(
                title: Text(
                  "Password:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                subtitle: TextFormField(
                  obscureText: isPassVisible,
                  controller: passwordcontroller,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 232, 126, 91),
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 232, 126, 91),
                              width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter your Password",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassVisible = !isPassVisible;
                            });
                          },
                          icon: Icon(isPassVisible
                              ? Icons.visibility_off
                              : Icons.visibility))),
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          MaterialButton(
            color: Color.fromARGB(255, 109, 83, 74),
            minWidth: 200,
            height: 50,
            onPressed: () {
              addData(usercontroller.text, emailcontroller.text,
                  passwordcontroller.text);
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailcontroller.text,
                      password: passwordcontroller.text)
                  .then((value) {
                print('Create new Account');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              }).onError((error, stackTrace) {
                print('Error ${error.toString()}');
              });
            },
            shape: RoundedRectangleBorder(),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create your Account?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ]))),
      ),
    ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intro_screen/screens.dart/login.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final emailcontroller = TextEditingController();
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
            Icons.lock,
            size: 150,
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
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: MaterialButton(
                  color: Colors.black,
                  minWidth: 350,
                  height: 50,
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailcontroller.text)
                        .then((value) {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(
                        email: emailcontroller.text,
                      )
                          .then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            )).onError((error, stackTrace) {
                          print('Error${error.toString()}');
                        });
                      });
                      Fluttertoast.showToast(
                          msg:
                              'We have sent you Email to recover password, please check Email.');
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(color: Colors.black)),
                  child: Text(
                    'Reset your Password',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
        ]))),
      ),
    ));
  }
}

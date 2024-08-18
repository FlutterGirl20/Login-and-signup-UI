import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen/screens.dart/forgotpass.dart';
import 'package:intro_screen/screens.dart/logout.dart';
import 'package:intro_screen/screens.dart/signup.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassVisible = true;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

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
          Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
          ),
          Icon(
            Icons.people,
            size: 200,
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotScreen(),
                          ));
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    )),
              )
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          MaterialButton(
            color: Color.fromARGB(255, 109, 83, 74),
            minWidth: 200,
            height: 50,
            onPressed: () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailcontroller.text,
                      password: passwordcontroller.text)
                  .then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    )).onError((error, stackTrace) {
                  print('Error${error.toString()}');
                });
              });
            },
            shape: RoundedRectangleBorder(),
            child: Text(
              'Log In',
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
                "Don't have an Account?",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                child: Text(
                  'Signup',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
              )
            ],
          )
        ]))),
      ),
    ));
  }
}

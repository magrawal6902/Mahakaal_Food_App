import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahakaal_food_app/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cpasswordController.text.trim();
    String fullName = fullNameController.text.trim();

    if(email == ""|| password == "" || cPassword == "" || fullName == ""){
      print("Please Fill all the Fields");
    }
    else if(password != cPassword){
      print("Passwords do not match");
    }
    else{
      signUp(email, password, fullName);
    }
  }

  void signUp(String email, String password, String fullName) async {
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch(ex){
      print(ex.code.toString());
    }

    if(credential != null){
      String uid = credential.user!.uid;
      UserModel newUser = UserModel(
        uid : uid,
        email: email,
        fullname: fullName,
      );

      await FirebaseFirestore.instance.collection("users").doc(uid).set(newUser.toMap()).then((value){
        print("New user created");
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             Home()));
        Navigator.of(context).pop();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Food App",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email Address"),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  TextField(
                    controller: cpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Confirm Password"),
                  ),
                  TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(labelText: "Full Name"),
                  ),
                  SizedBox(height: 20),
                  CupertinoButton(
                    onPressed: () {
                      checkValues();
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text("Sign Up"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already Have Account",
              style: TextStyle(fontSize: 16),
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "LogIn",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}


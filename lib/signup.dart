// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore_web/cloud_firestore_web.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/bottomAppBar.dart';
import 'package:flutter_ecommerce_app/login.dart';
import 'package:flutter_ecommerce_app/widgets/TextFieldWidget.dart';
import 'package:flutter_ecommerce_app/widgets/button_widget.dart';
import 'package:flutter_ecommerce_app/widgets/emailWidget.dart';
import 'package:flutter_ecommerce_app/widgets/passwordWidget.dart';
import 'package:flutter_ecommerce_app/widgets/text_Fields.dart';

class Signup extends StatefulWidget {
  static final String title = 'Firebase Upload'; // for upload
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isLoading = false;
  //forupload

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  get key => null;

  Widget _buildLoginBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextSpan(
                text: 'Already Have an Account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: RichText(
            text: TextSpan(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                TextSpan(
                  text: 'Login Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // UserCredential userCredential;
    RegExp regExp = RegExp("$key: \\[\\d+\\]");
    //validation
    TextEditingController Username = TextEditingController();
    TextEditingController Email = TextEditingController();
    TextEditingController Password = TextEditingController();
    TextEditingController CPassword = TextEditingController();

    GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    void validation() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: Email.text, password: Password.text);

        FirebaseFirestore.instance
            .collection('userinfo')
            .doc(auth.currentUser.uid)
            .set({
          "name": Username.text,
          "email": Email.text,
          "password": Password.text
        });
        Email.clear();
        Password.clear();
        Username.clear();
        CPassword.clear();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          SnackBar(content: Text("The account already exists for that email."));
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }

      //username validate
      if (Username.text.trim().isEmpty || Username.text.trim() == null) {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text("UserName is Empty")));
        return;
      }
      //email validate

      if (Email.text.trim().isEmpty || Email.text.trim() == null) {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text("Email is Empty")));
        return;
      } else if (!Email.text.contains("@") || !Email.text.contains(".")) {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text("Email is not valid")));
        return;
      }
//delete tis
      // else if(!regExp.hasMatch("@")){
      //              Navigator.pop(context);
      //              globalKey.currentState!
      //       .showSnackBar(SnackBar(content: Text("Empty")));
      //   return;
      //            }

      //email correction
      // else if (!regExp.hasMatch(Email.text)) {
      //   globalKey.currentState!
      //       .showSnackBar(SnackBar(content: Text("Provide Correct Email")));
      //   return;
      // }
//delete tis

      //password validate
      if (Password.text.trim().isEmpty || Password.text.trim() == null) {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text("Password is Empty")));
        return;
      }
      if (Password.text.length < 8) {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text("Password is Short")));
        return;
      }
      if (CPassword.text.trim().isEmpty || CPassword.text.trim() == null) {
        globalKey.currentState.showSnackBar(
            SnackBar(content: Text("Confirm Your Password First")));
        return;
      }
      if (CPassword.text.trim() != Password.text.trim()) {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text("Match Your Password")));
        return;
      }

      // else{
      //   // sendData();
      // }
      else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    }

    return SafeArea(
        minimum: const EdgeInsets.all(1.0),
        child: Scaffold(
            key: globalKey,
            backgroundColor: Colors.white,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Stack(children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        // margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            // ignore: prefer_const_literals_to_create_immutables
                            colors: [
                              Color(0xFF73AEF5),
                              Color(0xFF61A4F1),
                              Color(0xFF478DE0),
                              Color(0xFF398AE5),
                            ],
                            // ignore: prefer_const_literals_to_create_immutables
                            stops: [0.1, 0.4, 0.7, 0.9],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: double.infinity,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 60.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextFieldWidget(
                                icon: Icons.person,
                                controller: Username,
                                hintText: 'Username',
                              ),
                              SizedBox(height: 20.0),
                              EmailWidget(
                                controller: Email,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              PasswordWidget(
                                controller: Password,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              PasswordWidget(
                                text: "Confirm Password",
                                controller: CPassword,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 25.0),
                                width: double.infinity,
                                child: Container(
                                  height: 63,
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    onPressed: () => validation(),
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            color: Color(0xFF527DAA),
                                            strokeWidth: 1.0,
                                            value: 0.8)
                                        : Text(
                                            'Signup',
                                            style: TextStyle(
                                              color: Color(0xFF527DAA),
                                              letterSpacing: 1.5,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              _buildLoginBtn(),
                            ],
                          ),
                        ),
                      )
                    ])))));
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}




//upload image


 
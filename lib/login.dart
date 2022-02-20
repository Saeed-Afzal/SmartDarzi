import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/bottomAppBar.dart';
import 'package:flutter_ecommerce_app/signup.dart';
import 'package:flutter_ecommerce_app/widgets/text_Fields.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  // const Login({Key? key}) : super(key: key);
  login(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: EmailCont.text,
        password: PasswordCont.text,
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBar()),
          (route) => false);
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${e.message}',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
      if (e.code == 'user-not-found') {
        setState(() {
          _isLoading = false;
        });
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          _isLoading = false;
        });
        print('Wrong password provided for that user.');
      }
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$err',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  //validation
  TextEditingController EmailCont = TextEditingController();

  TextEditingController PasswordCont = TextEditingController();

  // TextEditingController CPassword = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Image.asset(
                  'assets/logo.png',
                )),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    MyTextField(
                      controller: EmailCont,
                      obscureText: false,
                      icon: Icons.email,
                      hintText: 'Email',
                    ),
                    // textField(
                    //     hintText: "Email",
                    //     icon: Icons.person_outline,
                    //     iconColor: Colors.blue),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: PasswordCont,
                      obscureText: true,
                      icon: Icons.lock,
                      hintText: 'Password',
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  width: 160,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(36.0),
                                      side: BorderSide(color: Colors.red)))),
                      onPressed: () {
                        login(context);
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Login')),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User? ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        "Register Now ",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

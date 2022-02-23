import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/Utilities/constants.dart';
import 'package:flutter_ecommerce_app/bottomAppBar.dart';
import 'package:flutter_ecommerce_app/signup.dart';
import 'package:flutter_ecommerce_app/widgets/emailWidget.dart';
import 'package:flutter_ecommerce_app/widgets/passwordWidget.dart';
import 'package:flutter_ecommerce_app/widgets/text_Fields.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  bool _rememberMe = false;

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

Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
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
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        EmailWidget(
                          controller: EmailCont,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        PasswordWidget(
                          controller: PasswordCont,
                        ),
                        _buildForgotPasswordBtn(),
                         _buildRememberMeCheckbox(),
                        // _buildLoginBtn(),
                        // _buildSignInWithText(),
                        // _buildSocialBtnRow(),
                        // _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

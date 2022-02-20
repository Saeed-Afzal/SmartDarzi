import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: UserProfileData(),
    );
  }
}

class UserProfileData extends StatefulWidget {
  @override
  State<UserProfileData> createState() => _UserProfileDataState();
}

Future getUserData() async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    var users = await FirebaseFirestore.instance
        .collection('userinfo')
        .doc(auth.currentUser.uid)
        .get();
    return users;
  } on FirebaseAuthException catch (e) {
    print(e.message);
    return [];
  } catch (e) {
    print(e);
    return [];
  }
}

class _UserProfileDataState extends State<UserProfileData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF00c6ff), Color(0xFF0072ff)],
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Stack(children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/logo.png'),
                                  radius: 60.0,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 4,
                                child: CircleAvatar(
                                  radius: 15,
                                  child: Icon(
                                    Icons.edit,
                                    size: 15,
                                  ),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data['name'],
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.email,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  snapshot.data['email'],
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Location: ',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Karachi, Pakistan',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.edit),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              '-Contact Us-',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      Icons.facebook_sharp,
                                      size: 35,
                                    )),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: FaIcon(
                                  FontAwesomeIcons.instagram,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text('Nothing to show'));
          }
          return Center(child: Text('Nothing to show'));
        });
  }
}

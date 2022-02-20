import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPage extends StatefulWidget {
  final String name;
  final String email;

  final String urlImage;

  const UserPage({
    Key key,
    this.name,
    this.email,
    this.urlImage,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: Image.asset(
          'assets/logo.png',
          // widget.urlImage,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
}

class GetUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference users =
        FirebaseFirestore.instance.collection('userinfo');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          // return Center(
          //   child: Container(
          //     child: Row(
          //       children: [
          //         Center(
          //           child: Container(
          //             child: Icon(
          //               Icons.people,

          //               size: 30.0,
          //             ),
          //           ),

          //         ),
          //         Container(
          //           child: Text("Name: ${data['name']}"),
          //         ),
          //         SizedBox(
          //           height: 40,
          //         ),
          //         Center(
          //           child: Container(
          //             child: Icon(
          //               Icons.email,

          //               size: 30.0,
          //             ),
          //           ),

          //         ),
          //         Container(
          //           child: Text("Email: ${data['email']}"),
          //         )
          //       ],
          //     ),
          //   ),
          // );

          return
              // Scaffold(
              //   // drawer: NavigationDrawerWidget(),
              //   appBar: AppBar(
              //     title: Text('My Profile'),
              //     // actions: [
              //     //   Padding(
              //     //       padding: EdgeInsets.all(15.0),
              //     //       child: GestureDetector(
              //     //         onTap: () {},
              //     //         child: FaIcon(FontAwesomeIcons.edit, size: 20,)
              //     //       )
              //     //       ),
              //     // ],
              //   ),
              //   body:
              SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF00c6ff), Color(0xFF0072ff)])),
                    child: Container(
                      width: double.infinity,
                      height: 300.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Stack(children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  // backgroundImage: NetworkImage(
                                  //   "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                                  // ),
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
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data['name'],
                                    style: TextStyle(
                                        fontSize: 32.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12.0),
                                child: Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Icon(
                                            Icons.email,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            data['email'],
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Location:",
                          style: TextStyle(
                              color: Colors.blue,
                              fontStyle: FontStyle.normal,
                              fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Karachi,Pakistan',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                letterSpacing: 2.0,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text("-Contact Us-",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Container(
                              child: Center(
                            child: Row(
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
                          )),
                        ),
                        // GFButton(
                        //   onPressed: () {},
                        //   icon: Icon(
                        //     Icons.facebook,
                        //     color: Colors.blue,
                        //   ),
                        //   type: GFButtonType.outline2x,
                        // ),
                        // CircleAvatar(
                        //   radius: 120,
                        //   child: GFIconButton(
                        //     onPressed: () {},
                        //     icon: Icon(Icons.facebook),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20.0,
                // ),
              ],
            ),
            // ),
          );

          // Text("Name: ${data['name']} Email: ${data['email']}",

          // );
        }

        return Text("loading");
      },
    );
  }
}

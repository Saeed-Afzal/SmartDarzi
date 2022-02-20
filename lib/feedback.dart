import 'package:flutter/material.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Feedbac extends StatefulWidget {
  // const Feedback({ Key? key }) : super(key: key);

  @override
  _FeedbacState createState() => _FeedbacState();
}

class _FeedbacState extends State<Feedbac> {
  var rating = 3.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF00c6ff), Color(0xFF0072ff)])),
                child: Container(
                  width: double.infinity,
                  height: 300.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            backgroundImage: AssetImage('contact.png'),
                            radius: 60.0,
                            
                          ),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 4,
                        //   child: CircleAvatar(
                        //     radius: 15,
                        //     // child: Icon(
                        //     //   Icons.edit,
                        //     //   size: 15,
                        //     // ),
                        //   ),
                        // )
                      ]),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rate Us',
                              style: TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'A Satisfied Customer is the Best \n Business Strategy of all',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                            // Positioned(
                            //   bottom: 0,
                            //   right: 0,
                            //   // child: Icon(
                            //   //   Icons.edit,
                            //   //   size: 20,
                            //   //   color: Colors.white,
                            //   // ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Text("Rate Us"),
              SizedBox(
                height: 20.0,
              ),



              // EmojiFeedback(),



                  SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) {
           },
          starCount: 5,
          rating: rating,
          size: 40.0,
          isReadOnly:false,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          // fullRatedIconData: Icons.blur_off,
          // halfRatedIconData: Icons.blur_on,
          color: Colors.blue,
          borderColor: Colors.blue,
          spacing:0.0
    ),

              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 60,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  // controller: message,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Write Review",
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ElevatedButton(
                  // controller: _btnController,
                  onPressed: () => _onAlertWithCustomImagePressed(context),
                    // Navigator.pop(context);
                  
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    // side: BorderSide(color: Colors.red)
                  ))),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Alert custom images
  _onAlertWithCustomImagePressed(context) {
    Alert(
      context: context,
      title: "Review Submitted",
      desc: "Thanks for your Feedback.",
      image: Image.asset("check.gif", width: 100,),
    ).show();
  }
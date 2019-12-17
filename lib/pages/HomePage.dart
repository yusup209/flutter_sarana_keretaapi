import 'package:flutter/material.dart';
import '../main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;


class HomePage extends StatelessWidget {
  final UserDetails detailsUser;

  HomePage({Key key, @required this.detailsUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn =  GoogleSignIn();

    return  Scaffold(
        appBar:  AppBar(
          title:  Text('Sarana Kereta Api'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                size: 20.0,
                color: Colors.white,
              ),
              onPressed: (){
                _gSignIn.signOut();
                print('Signed out');
                Navigator.pop(context);

              },
            ),
          ],
        ),
        body:Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage:NetworkImage(detailsUser.photoUrl),
              radius: 50.0,
            ),
            SizedBox(height:10.0),
            Text(
              "Name : " + detailsUser.userName,
              style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20.0),
            ),
            SizedBox(height:10.0),
            Text(
              "Email : " + detailsUser.userEmail,
              style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20.0),
            ),
          ],
        ),)
    );
  }
}

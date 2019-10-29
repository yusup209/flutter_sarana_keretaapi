import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/services.dart';
import 'delayed_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'pages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sarana Kereta Api',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff9C58D2),
      ),
      home: LoginSarana(),
    );
  }
}

class LoginSarana extends StatefulWidget {
  @override
  _LoginSaranaState createState() => _LoginSaranaState();
}

class _LoginSaranaState extends State<LoginSarana>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  final int delayedAmount = 500;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  Future<FirebaseUser> _signIn(BuildContext context) async {
    final snackBar = new SnackBar(content: Text('Sign In'));
    Scaffold.of(context).showSnackBar(snackBar);

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails =
        await _firebaseAuth.signInWithCredential(credential);
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ProfileScreen(detailsUser: details),
      ),
    );
    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    const padding = 15.0;
    return Scaffold(
        backgroundColor: Color(0xFF0F3443),
        body: Builder(
            builder: (context) => Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70.0,
                      ),
                      AvatarGlow(
                        endRadius: 180,
                        duration: Duration(seconds: 2),
                        glowColor: Colors.white24,
                        repeat: true,
                        repeatPauseDuration: Duration(seconds: 2),
                        startDelay: Duration(seconds: 1),
                        child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/cybertrain.png'),
                              backgroundColor: Colors.transparent,
                              radius: 3000.0,
                            )),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      DelayedAimation(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              width: 100.0,
                            ),
                            Container(
                                width: 250.0,
                                padding:
                                    EdgeInsets.only(right: 30.0, left: 30.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)),
                                    color: Color(0xffffffff),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.google,
                                          color: Color(0xffCE107C),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                          height: 50.0,
                                        ),
                                        Text(
                                          'Masuk dengan Google',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                    onPressed: () => _signIn(context)
                                        .then(
                                            (FirebaseUser user) => print(user))
                                        .catchError((e) => print(e)),
                                  ),
                                )),
                            SizedBox(
                              height: 20.0,
                              width: 10.0,
                            ),
                            Container(
                                width: 250.0,
                                padding:
                                    EdgeInsets.only(right: 30.0, left: 30.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)),
                                    color: Colors.blueAccent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.facebook,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                          height: 50.0,
                                        ),
                                        Text(
                                          'Masuk dengan Facebook',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {}
                                  ),
                                )),
                            SizedBox(
                              height: 40.0,
                            ),
                          ],
                        ),
                      ),
                      DelayedAimation(
                        child: Text(
                          "Butuh Bantuan?",
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                        delay: delayedAmount + 1000,
                      ),
                    ],
                  ),
                )
            //  Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
            //     SizedBox(
            //       height: 20.0,
            //     ),
            //      Center(

            //   ),
            //   ],

            // ),
            ));
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 12.0, bottom: 12.0));
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/initial.dart';

class IntroAnimation extends StatefulWidget {
  @override
  _IntroAnimationState createState() => _IntroAnimationState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _IntroAnimationState extends State<IntroAnimation> {
  startAnimation() async {
    Future.delayed(Duration(
      seconds: 2,
    )).then((onLoaded) {
      Navigator.of(context).pushReplacement(FadeNavigator());
    });
  }

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00B7BD),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FlareActor(
          "assets/animations/SwappinIntro2.flr",
          alignment: Alignment.center,
          fit: BoxFit.cover,
          animation: "splash",
        ),
      ),
    );
  }
}

class FadeNavigator extends CupertinoPageRoute {
  FadeNavigator()
      : super(builder: (BuildContext context) => IntroLandingPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: IntroLandingPage());
  }
}

class IntroLandingPage extends StatefulWidget {
  @override
  _IntroLandingPageState createState() => _IntroLandingPageState();
}

class _IntroLandingPageState extends State<IntroLandingPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: _auth.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData && !snapshot.data.isAnonymous)
          return App();
        else
          return Initial();
      },
    );
  }
}
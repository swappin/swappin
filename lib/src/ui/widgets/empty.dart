import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  final String image;
  EmptyScreen({this.message, this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Image.asset(
                "assets/no-$image.png",
                width: 250,
              ),
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Color(0xFF00BFB2),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

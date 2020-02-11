import 'package:flutter/material.dart';
/* Logo */
class LogoVertical extends StatefulWidget {
  @override
  _LogoVerticalState createState() => _LogoVerticalState();
}

class _LogoVerticalState extends State<LogoVertical> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 80.0, bottom: 20.0),
            child: Image.asset(
              'assets/logo_vertical.png',
              width: 150.0,
              height: 150.0,
            ),
          ),
          Container(
            height: 80.0,
            child: Column(
              children: <Widget>[
                Text(
                  'Olá',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Como deseja começar?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

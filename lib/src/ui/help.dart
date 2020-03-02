import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              "assets/icons/black/arrow_left_1.png",
              width: 10.0,
            ),
          ),
        ),
        title: Text(
          "Ajuda",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Color(
              0xFF00BFB2,
            ),
          ),
        ),
      ),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
            child: Column(
              children: <Widget>[
                //Introdução
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Nos conte o seu problema!",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Para qualquer tipo de assunto, seja dúvidas, reclamações, opiniões, etc., favor nos contatar. Responderemos o mais rápido possível. Por favor, envie e-mail para:",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "swappin@swappin.io",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Color(
                        0xFF00BFB2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

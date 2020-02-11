import 'package:flutter/material.dart';

class NoStoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Image.asset(
              "assets/no-stores.png",
              width: 250,
            ),
          ),
          Text(
            "Ooops, parece que não há nada próximo ou aberto na categoria.",
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
    );
  }
}

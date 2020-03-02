import 'package:flutter/material.dart';
import 'package:swappin/src/ui/legal/privacy-policy.dart';

class Policy extends StatelessWidget {
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
              width: 10,
            ),
          ),
        ),
        title: Text(
          "Política de Privacidade",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Color(
              0xFF00BFB2,
            ),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment(0.0, 0.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: PrivacyPolicy(),
      ),
    );
  }
}

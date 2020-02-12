import 'package:flutter/material.dart';
import 'package:swappin/src/ui/about.dart';
import 'package:swappin/src/ui/edit.dart';
import 'package:swappin/src/ui/faq.dart';
import 'package:swappin/src/ui/policy.dart';
import 'package:swappin/src/ui/security.dart';
import 'package:swappin/src/ui/terms.dart';

class Config extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Image.asset(
            "assets/icons/black/arrow_left_1.png",
            width: 10.0,
          ),
        ),
        title: Text(
          "Configurações",
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
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/profile.png",
                  width: 20,
                ),
              ),
              title: Text(
                "Editar Perfil",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
              trailing: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/arrow_right.png",
                  width: 8,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE3E4E5),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/password.png",
                  width: 20,
                ),
              ),
              title: Text(
                "Senha & Segurança",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
              trailing: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/arrow_right.png",
                  width: 8,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Security(),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE3E4E5),
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/swappin-logo.png",
                  width: 25,
                ),
              ),
              title: Text(
                "Sobre a Swappin",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
              trailing: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/arrow_right.png",
                  width: 8,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE3E4E5),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/terms.png",
                  width: 17,
                ),
              ),
              title: Text(
                "Termos de Uso",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
              trailing: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/arrow_right.png",
                  width: 8,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Terms(),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE3E4E5),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/policy.png",
                  width: 17,
                ),
              ),
              title: Text(
                "Política de Privacidade",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
              trailing: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/arrow_right.png",
                  width: 8,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Policy(),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE3E4E5),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/question.png",
                  width: 17,
                ),
              ),
              title: Text(
                "FAQ",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
              trailing: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/arrow_right.png",
                  width: 8,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FAQ(),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE3E4E5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

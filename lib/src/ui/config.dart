import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swappin/src/initial.dart';
import 'package:swappin/src/ui/about.dart';
import 'package:swappin/src/ui/edit.dart';
import 'package:swappin/src/ui/help.dart';
import 'package:swappin/src/ui/policy.dart';
import 'package:swappin/src/ui/security.dart';
import 'package:swappin/src/ui/terms.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
      body: SafeArea(
        child: Container(
          child: Column(
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
                    "Ajuda",
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
                      builder: (context) => Help(),
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

              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    child: Text(
                      "Sair",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00BFB2),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      await _auth.signOut().then(
                            (onValue) => prefs.remove("range").then(
                              (onRemove) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Initial(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

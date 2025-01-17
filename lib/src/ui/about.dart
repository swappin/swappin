import 'package:flutter/material.dart';

class About extends StatelessWidget {
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
          "Sobre a Swappin",
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
                    "O que quiser, onde estiver.",
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
                    "A Swappin é um aplicativo que conecta usuários à produtos e lojas próximas de um modo simples e prática. Com a Swappin você pode saber a distância das lojas próximas e acessar os produtos vendidos por estas, pesquisar e comparar preços dos produtos próximos a você, realizar suas compras com tranquilidade e retirar no local quando quiser. Caso já esteja no local, como um resraurante, por exemplo, é só fazer check-in, pedir da mesa e receber sem precisar de filas. Com a Swappin você encontra o que quiser, onde estiver.",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    "Saiba mais. Acesse:",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "www.swappin.io",
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

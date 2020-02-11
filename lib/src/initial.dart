import 'package:flutter/material.dart';
import 'package:swappin/src/ui/login.dart';
import 'package:swappin/src/ui/register.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';

class Initial extends StatefulWidget {
  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        width: double.infinity,
        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/background.jpg"),
//            fit: BoxFit.fill,
//          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 75),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/logo.png",
                  width: 58,
                ),
              ),
            ),
            Container(
              height: 65,
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: Color(0xFF00BFB2),
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "O que "),
                    TextSpan(
                      text: "quiser, ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF02b9bf),
                      ),
                    ),
                    TextSpan(
                      text: "onde ",
                    ),
                    TextSpan(
                        text: "estiver.",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF02b9bf),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              height: 65,
              width: double.infinity,
              child: SwappinButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ),
                ),
                child: Text(
                  "Criar Conta",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(margin: EdgeInsets.only(top: 6, bottom: 6)),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 65,
                width: double.infinity,
                child: FlatButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      )),
                  child: RichText(
                    softWrap: true,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: "Já possui uma conta?"),
                        TextSpan(
                          text: " Entrar",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF05A9C7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

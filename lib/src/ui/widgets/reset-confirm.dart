import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/ui/login.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';

class ResetConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: LoginBlocProvider(
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage("assets/background.jpg"),
//              fit: BoxFit.fill,
//            ),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/logo.png",
                      width: 58,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "E-mail enviado com sucesso.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Verifique sua caixa de entrada.",
                          style: TextStyle(
                            color: Color(0xFF00BFB2),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                        ),
                        Container(margin: EdgeInsets.only(bottom: 25)),
                        Container(
                          height: 60,
                          width: double.infinity,
                          child: SwappinButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            ),
                            child: Text(
                              "Retornar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(margin: EdgeInsets.only(top: 50, bottom: 50)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

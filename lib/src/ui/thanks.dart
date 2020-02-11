import 'package:flutter/material.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/ui/home.dart';

class ThanksScreen extends StatelessWidget {
  final String userName;

  ThanksScreen({
    Key key,
    this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Obrigado, $userName!"),
              FlatButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(currentIndex: 0),
                    ),
                  );
                },
                child: Text("Retornar à Home."),
              )
            ],
          )),
    );
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:swappin/src/app.dart';

class Tutorial extends StatefulWidget {
  final String email;
  final String name;
  final String photoURL;

  Tutorial({Key key, this.email, this.name, this.photoURL}) : super(key: key);

  @override
  _TutorialState createState() => new _TutorialState(
        email: this.email,
        name: this.name,
        photoURL: this.photoURL,
      );
}

class _TutorialState extends State<Tutorial> {
  String email;
  String name;
  String photoURL;
  String _animation = "normal";
  String _tutorialTitle = "Explore a sua região";
  String _tutorialDescription = "Lorem ipsum que se foda";
  String _stepText = "Avançar";

  _tutorialAnimation(int index) {
    if (index == 1) {
      _animation = "acess";
    }
  }

  _TutorialState({this.email, this.name, this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          FlareActor(
            "assets/animations/Tutorial.flr",
            alignment: Alignment.center,
            fit: BoxFit.cover,
            animation: _animation,
          ),
          SafeArea(
              child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: EdgeInsets.fromLTRB(35, 110, 35, 0),
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Container(
                        margin: EdgeInsets.only(bottom: 25),
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/logo-white.png",
                          width: 58,
                        ),
                      ),
                        Text(
                          _tutorialTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            color: Color(0xFF96ffe7),
                          ),
                        ),
                        Text(
                          _tutorialDescription,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                  height: 76,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 30),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text("Pular",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Color(0xFF96ffe7),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_animation == "normal") {
                                _tutorialTitle = "Filtre os produtos";
                                _tutorialDescription = "E compare os preços";
                                _animation = "filter";
                              } else if (_animation == "filter") {
                                _tutorialTitle = "Faça check-in";
                                _tutorialDescription = "E acesse todos os produtos";
                                _animation = "acess";
                              } else if (_animation == "acess") {
                                _tutorialTitle = "Compre com tranquilidade";
                                _tutorialDescription = "E receba na hora ou retire depois";
                                _stepText = "Concluir";
                                if(_stepText == "Concluir"){
                                  Navigator.of(context).pushReplacement((MaterialPageRoute(
                                    builder: (context) => App(),
                                  )));
                                }
                              }
                            });
                          },
                          child: Text(_stepText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),),
                        ),
                      ),
                    ],
                  )),
            ],
          )),
        ],
      ),
    ));
  }
}

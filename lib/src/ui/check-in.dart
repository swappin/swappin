import 'package:flutter/material.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/products.dart';

class CheckIn extends StatefulWidget {
  final String store;
  final String adress;
  final String photo;
  final String delivery;
  final num score;
  final num distance;

  const CheckIn(
      {Key key,
      @required this.store,
      this.adress,
      this.photo,
      this.delivery,
      this.score,
      this.distance})
      : super(key: key);

  @override
  _CheckInState createState() => _CheckInState(
        store: this.store,
        adress: this.adress,
        photo: this.photo,
        delivery: this.delivery,
        score: this.score,
        distance: this.distance,
      );
}

class _CheckInState extends State<CheckIn> {
  String store;
  String adress;
  String photo;
  String delivery;
  num score;
  num distance;

  _CheckInState(
      {this.store,
      this.adress,
      this.photo,
      this.delivery,
      this.score,
      this.distance});

  @override
  Widget build(BuildContext context) {
    return currentUserName != null
        ? Scaffold(
            body: Container(
              padding: EdgeInsets.all(20.0),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 75.0,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Olá, $currentUserName",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Você está em $store",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white,
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => Products(
                            store: store,
                            adress: adress,
                            photo: photo,
                            delivery: delivery,
                            score: score,
                            distance: distance,
                          ),
                        );
                        Navigator.pushReplacement(context, route);
                      },
                      child: Text(
                        "Fazer Check-In",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Color(0xFF00BFB2),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60.0,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => Home(currentIndex: 0),
                        );
                        Navigator.pushReplacement(context, route);
                      },
                      child: Text(
                        "Explorar",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20.0),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )),
          );
  }
}

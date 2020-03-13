import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:swappin/src/ui/widgets/empty.dart';

class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  String loading = "loading";

  verifyConnection() async {
    try {
      final result = await InternetAddress.lookup('swappin.io');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          loading = "loading";
        });
      }
    } on SocketException catch (_) {
      Future.delayed(Duration(
        milliseconds: 4600,
      )).then((onLoaded) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EmptyScreen(
              message:
                  "Ooops, parece que você está sem conexão!\nTente novamente...",
              image: "internet",
            ),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    verifyConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FlareActor(
          "assets/animations/SwappinLoading.flr",
          alignment: Alignment.center,
          fit: BoxFit.cover,
          animation: loading,
        ),
      ),
    );
  }
}

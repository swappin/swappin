import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/blocs/stores_bloc_provider.dart';
import 'package:swappin/src/models/store.dart';
import 'package:swappin/src/ui/check-in.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/widgets/empty.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser user;
String currentUserUID;
String currentUserName;
String currentUserEmail;
String currentUserPhoto;
int userRange;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  StoresBloc _storesBloc;

  void getCurrentUser() async {
    user = await _auth.currentUser();
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      if (user.isAnonymous != true) {
        await Firestore.instance
            .collection('users')
            .document(user.email)
            .get()
            .then((userData) {
          setState(() {
            currentUserUID = user.uid;
            currentUserName = userData['name'];
            currentUserEmail = userData['email'];
            currentUserPhoto = userData['photo'];
          });
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmptyScreen(
              message: "Sentimos muito, mas algo de errado aconteceu!",
              image: "internet",
            ),
          ),
        );
      }
    }
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRange = prefs.getInt('range');
    });
  }

  @override
  void initState() {
    super.initState();
    getStringValuesSF();
    getCurrentUser();
    latitude = latitude != null ? latitude : -23.534600;
    longitude = longitude != null ? longitude : -46.531828;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _storesBloc = StoresBlocProvider.of(context);
  }

  @override
  void dispose() {
    _storesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _storesBloc.searchList(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && currentUserName != null) {
          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<Store> storesList = _storesBloc.mapToList(docList: docs);
          if (storesList.isNotEmpty) {
            storesList.sort((a, b) => a.meters.compareTo(b.meters));
            return homeBuider(storesList);
          } else {
            return EmptyScreen(
              message: "Eita, sua sacaola está vazia!\nBora fazer umas comprinhas?",
              image: "stores",
            );
          }
        } else {
          return LoaderScreen();
        }
      },
    );
  }

  Widget homeBuider(List<Store> storesList) {
    if (storesList[0].meters >= 5) {
      return Home(currentIndex: 0);
    } else {
      return CheckIn(
        store: storesList[0].name,
        adress: storesList[0].adress,
        photo: storesList[0].photo,
        delivery: storesList[0].delivery,
        score: storesList[0].score,
        distance: storesList[0].meters,
      );
    }
  }
}

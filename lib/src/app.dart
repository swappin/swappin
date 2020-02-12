import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/blocs/stores_bloc_provider.dart';
import 'package:swappin/src/models/order.dart';
import 'package:swappin/src/models/store.dart';
import 'package:swappin/src/ui/check-in.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/widgets/no-internet.dart';
import 'package:swappin/src/ui/widgets/no-stores.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/utils/strings.dart';
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
    final result = await InternetAddress.lookup('swappin.io');
    if (result.isNotEmpty &&
        result[0].rawAddress.isNotEmpty &&
        user.isAnonymous != true) {
      var document = await Firestore.instance
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
    longitude = longitude != null  ? longitude : -46.531828;
    print("Latitude: $latitude");
    print("Longitude: $longitude");
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
    print(currentUserEmail);
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
            return NoInternetScreen();
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

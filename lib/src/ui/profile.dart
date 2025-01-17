import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/user_bloc.dart';
import 'package:swappin/src/blocs/user_bloc_provider.dart';
import 'package:swappin/src/initial.dart';
import 'package:swappin/src/models/user.dart';
import 'package:swappin/src/ui/config.dart';
import 'package:swappin/src/ui/historic.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:swappin/src/ui/widgets/swappin-icon.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserBloc _bloc;
  RangeValues _values = RangeValues(100, 2500);
  static List<String> userInitials = currentUserName.split(" ");
  String initialLetter = userInitials[0][0].toUpperCase();
  String _adress;

  LocationData _startLocation;
  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _location = new Location();

  bool _permission = false;
  String error;

  updateRange(int range) {
    setState(() {
      userRange = range;
    });
    addStringToSF(range);
  }

  addStringToSF(int range) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('range', range);
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRange = prefs.getInt('range');
    });
  }

  Future<String> _getAddress() async {
    List<Placemark> placemarks =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      setState(() {
        _adress = pos.thoroughfare + ', ' + pos.locality;
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  getCurrentLocation() async {
    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation();
      _permission = await _location.hasPermission();

      _locationSubscription =
          _location.onLocationChanged().listen((LocationData result) {
        setState(() {
          _currentLocation = result;
          latitude = result.latitude;
          longitude = result.longitude;
        });
      });
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
      _startLocation = location;
      latitude = location.latitude;
      longitude = location.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAddress();
    getCurrentLocation();
    if (userRange == null) {
      userRange = 2500;
      addStringToSF(2500);
    }
    ;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = UserBlocProvider.of(context);

    location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        latitude =
            currentLocation != null ? currentLocation.latitude : -23.534600;
        longitude =
            currentLocation != null ? currentLocation.longitude : -23.534600;
        _getAddress();
      });
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(),
        actions: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            padding: EdgeInsets.only(right: 30),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(
                        currentIndex: 0,
                      ),
                    ));
              },
              child: Opacity(
                opacity: 0.65,
                child: Image.asset(
                  "assets/icons/black/home.png",
                  width: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 120.0,
                        alignment: Alignment.topLeft,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [0.1, 0.9],
                                    colors: [
                                      Color(0xFF00BFB2),
                                      Color(0xFF05A9C7),
                                    ],
                                  ),
                                ),
                              ),
                              currentUserPhoto != null
                                  ? Container(
                                      width: 112,
                                      height: 112,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: Colors.white, width: 4),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              currentUserPhoto,
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : Container(
                                      width: 112,
                                      height: 112,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: Colors.white, width: 4),
                                      ),
                                      child: Text(
                                        initialLetter,
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        currentUserName,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Color(0xFF00BFB2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFE8E8E8),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Quero me deslocar:",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Text(
                            "${userRange.toInt().toString()}m",
                            style: const TextStyle(
                              color: Color(0xFF00BFB2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Slider.adaptive(
                      activeColor: Color(0xFF00BFB2),
                      value: userRange != null ? userRange.toDouble() : 2500,
                      onChanged: (double range) {
                        setState(() {
                          updateRange(range.toInt());
                        });
                      },
                      min: 100,
                      max: 2500,
                      divisions: 48,
                      label: "${userRange.toInt().toString()}m",
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoricScreen(),
                  ),
                ),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFE8E8E8),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Opacity(
                          opacity: 0.35,
                          child: SwappinIcon(
                            icon: "files",
                            firstColor: Colors.black,
                            secondColor: Colors.black,
                            width: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Histórico",
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//              Container(
//                decoration: BoxDecoration(
//                  border: Border(
//                    bottom: BorderSide(
//                      color: Color(0xFFE8E8E8),
//                      width: 1.0,
//                    ),
//                  ),
//                ),
//                child: ListTile(
//                  leading: Opacity(
//                    opacity: 0.35,
//                    child: SwappinIcon(
//                      icon: "policy",
//                      firstColor: Colors.black,
//                      secondColor: Colors.black,
//                      width: 18,
//                    ),
//                  ),
//                  title: Text(
//                    "Lista de Desejos",
//                    style: const TextStyle(
//                      fontWeight: FontWeight.bold,
//                      fontSize: 12.0,
//                      fontFamily: 'Poppins',
//                    ),
//                  ),
//                  subtitle: Text(
//                    "Tudo o que eu desejo comprar",
//                    style: TextStyle(fontSize: 12.0),
//                  ),
//                  onTap: () {
//                    // Update the state of the app.
//                    // ...
//                  },
//                  trailing: Icon(
//                    Icons.arrow_forward_ios,
//                    size: 16.0,
//                  ),
//                ),
//              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Config(),
                  ),
                ),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFE8E8E8),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Opacity(
                          opacity: 0.35,
                          child: SwappinIcon(
                            icon: "settings",
                            firstColor: Colors.black,
                            secondColor: Colors.black,
                            width: 20,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Condigurações",
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  getCurrentLocation();
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFE8E8E8),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Opacity(
                          opacity: 0.35,
                          child: SwappinIcon(
                            icon: "pin_sharp_circle",
                            firstColor: Colors.black,
                            secondColor: Colors.black,
                            width: 15,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          _adress != null ? _adress : "Buscando endereço...",
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ProfileError() {
    return Container(
      child: Text("Profile Error"),
    );
  }

  Widget RangeError() {
    return Container(
      child: Text("Range Error"),
    );
  }
}

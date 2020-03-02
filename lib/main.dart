import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:swappin/src/ui/animations/intro.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/bag_bloc_provider.dart';
import 'package:swappin/src/blocs/coupon_bloc_provider.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/blocs/orders_bloc_provider.dart';
import 'package:swappin/src/blocs/products_bloc_provider.dart';
import 'package:swappin/src/blocs/stores_bloc_provider.dart';
import 'package:swappin/src/blocs/user_bloc_provider.dart';
import 'package:swappin/src/initial.dart';
import 'package:swappin/src/ui/login.dart';
import 'package:swappin/src/ui/animations/loader.dart';


var location = Location();

double latitude;
double longitude;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  location.onLocationChanged().listen((LocationData currentLocation) {
    latitude = currentLocation != null ? currentLocation.latitude : -23.534600;
    longitude = currentLocation != null ? currentLocation.longitude : -23.534600;
  });
  runApp(
    LoginBlocProvider(
      child: UserBlocProvider(
        child: StoresBlocProvider(
          child: ProductsBlocProvider(
            child: OrdersBlocProvider(
              child: BagBlocProvider(
                child: CouponBlocProvider(
                  child: UserBlocProvider(
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        brightness: Brightness.light,
                        primaryColor: Color(0xFF00BFB2),
                      ),
                      home: await IntroAnimation(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}


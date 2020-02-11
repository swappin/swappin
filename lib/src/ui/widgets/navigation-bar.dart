import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/bag_bloc.dart';
import 'package:swappin/src/blocs/bag_bloc_provider.dart';
import 'package:swappin/src/blocs/orders_bloc.dart';
import 'package:swappin/src/blocs/orders_bloc_provider.dart';
import 'package:swappin/src/blocs/user_bloc.dart';
import 'package:swappin/src/blocs/user_bloc_provider.dart';
import 'package:swappin/src/models/bag.dart';
import 'package:swappin/src/models/order.dart';
import 'package:swappin/src/ui/bag.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/map.dart';
import 'package:swappin/src/ui/notifications.dart';
import 'package:swappin/src/ui/transformers/category-transformer.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  UserBloc _userBloc;
  OrdersBloc _ordersBloc;
  BagBloc _bagBloc;
  int currentIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _screenNavigator = <Widget>[
    categoryNavigator(),
    MapScreen(),
    BagScreen(),
    NotificationScreen(),
  ];

  _bagCounter(int bagNumber) {
    if (bagNumber == 0) {
      return Opacity(
        opacity: 0.5,
        child: Image.asset(
          "assets/icons/black/bag.png",
          width: 20.0,
        ),
      );
    } else {
      return Badge(
        padding: EdgeInsets.all(5.0),
        position: BadgePosition.topRight(top: -8, right: -4),
        badgeContent: Text(
          bagNumber.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.0,
            fontFamily: 'Poppins',
          ),
        ),
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            "assets/icons/black/bag.png",
            width: 20.0,
          ),
        ),
      );
    }
  }

  _notificationCounter(int notificationNumber) {
    if (notificationNumber == 0) {
      return Opacity(
        opacity: 0.5,
        child: Image.asset(
          "assets/icons/black/clock.png",
          width: 20.0,
        ),
      );
    } else {
      return Badge(
        padding: EdgeInsets.all(5.0),
        position: BadgePosition.topRight(top: -8, right: -4),
        badgeContent: Text(
          notificationNumber.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.0,
            fontFamily: 'Poppins',
          ),
        ),
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            "assets/icons/black/clock.png",
            width: 20.0,
          ),
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userBloc = UserBlocProvider.of(context);
    _ordersBloc = OrdersBlocProvider.of(context);
    _bagBloc = BagBlocProvider.of(context);
  }

  @override
  void dispose() {
    _userBloc.dispose();
    _ordersBloc.dispose();
    _bagBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) =>
          setState(() {
            currentIndex = index;
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Home(currentIndex: index),
            ));
          }),
      elevation: 0.0,
      items: [
        BottomNavigationBarItem(
          icon: Opacity(
            opacity: 0.5,
            child: Image.asset(
              "assets/icons/black/home.png",
              width: 18.0,
            ),
          ),
          activeIcon: Opacity(
            opacity: 1.0,
            child: Image.asset(
              "assets/icons/gradient/home.png",
              width: 18.0,
            ),
          ),
          title: Text(
            'Home',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(padding: EdgeInsets.only(bottom: 4.0),
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/icons/black/pin_sharp_circle.png",
                width: 18.0,
              ),
            ),
          ),
          activeIcon: Padding(padding: EdgeInsets.only(bottom: 4.0),
            child: Opacity(
              opacity: 1.0,
              child: Image.asset(
                "assets/icons/gradient/pin.png",
                width: 18.0,
              ),
            ),
          ),
          title: Text(
            'Mapa',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: StreamBuilder(
            stream: _bagBloc.getBagItens(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> docs = snapshot.data.documents;
                List<Bag> bagListener = _bagBloc.mapToList(docList: docs);
                if (bagListener.isNotEmpty) {
                  bagListener
                      .sort((b, a) => a.storeName.compareTo(b.storeName));

                  return _bagCounter(bagListener.length);
                } else {
                  return _bagCounter(0);
                }
              } else {
                return _bagCounter(0);
              }
            },
          ),
          title: Text(
            "Sacola",
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: StreamBuilder(
            stream: _ordersBloc.getNotifications(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> docs = snapshot.data.documents;
                List<Order> statusListener =
                _ordersBloc.mapToList(docList: docs);
                if (statusListener.isNotEmpty) {
                  statusListener
                      .sort((b, a) => a.finalDate.compareTo(b.finalDate));
                  return _notificationCounter(statusListener.length);
                } else {
                  return _notificationCounter(0);
                }
              } else {
                return _notificationCounter(0);
              }
            },
          ),
          title: Text(
            "Notificações",
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}

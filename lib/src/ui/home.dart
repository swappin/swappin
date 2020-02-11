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
import 'package:swappin/src/ui/search.dart';
import 'package:swappin/src/ui/transformers/category-transformer.dart';
import 'package:swappin/src/ui/map.dart';
import 'package:swappin/src/ui/notifications.dart';
import 'package:swappin/src/ui/profile.dart';

class Home extends StatefulWidget {
  final int currentIndex;

  Home({
    Key key,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  HomeState createState() {
    return HomeState(currentIndex: this.currentIndex);
  }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  UserBloc _userBloc;
  OrdersBloc _ordersBloc;
  BagBloc _bagBloc;
  int currentIndex = 0;
  static List<String> userInitials = currentUserName.split(" ");
  String initialLetter = userInitials[0][0].toUpperCase();

  HomeState({this.currentIndex});

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
    return Scaffold(
      appBar: currentIndex == 0
          ? PreferredSize(
              preferredSize: Size.fromHeight(106.0), // here the desired height
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 78.0,
                      height: 78.0,
                      alignment: Alignment.topLeft,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Profile(),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                // Box decoration takes a gradient
                                gradient: LinearGradient(
                                  // Where the linear gradient begins and ends
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  // Add one stop for each color. Stops should increase from 0 to 1
                                  stops: [0.1, 0.9],
                                  colors: [
                                    // Colors are easy thanks to Flutter's Colors class.
                                    Color(0xFF00BFB2),
                                    Color(0xFF05A9C7),
                                  ],
                                ),
                              ),
                            ),
                            currentUserPhoto != null
                                ? Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                          color: Colors.white, width: 4.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            currentUserPhoto,
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Container(
                                    width: 70.0,
                                    height: 70.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                          color: Colors.white, width: 4.0),
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
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 78.0,
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Bem-vindo à Swappin",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              currentUserName,
                              style: TextStyle(
                                fontSize: 15.0,
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
                      width: 50.0,
                      height: 50.0,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ));
                        },
                        child: Opacity(
                          opacity: 0.65,
                          child: Image.asset(
                            "assets/icons/black/search.png",
                            width: 22.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: Center(
        child: _screenNavigator.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/icons/black/home.png",
                width: 19.0,
              ),
            ),
            activeIcon: Opacity(
              opacity: 1.0,
              child: Image.asset(
                "assets/icons/gradient/home.png",
                width: 19.0,
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
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/icons/black/pin_sharp_circle.png",
                  width: 16.0,
                ),
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Opacity(
                opacity: 1.0,
                child: Image.asset(
                  "assets/icons/gradient/pin.png",
                  width: 17.0,
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
            activeIcon: Image.asset(
              "assets/icons/gradient/bag.png",
              width: 20.0,
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
            activeIcon: Image.asset(
              "assets/icons/gradient/clock.png",
              width: 20.0,
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
      ),
      drawer: Profile(),
    );
  }
}

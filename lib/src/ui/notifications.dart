import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/orders_bloc.dart';
import 'package:swappin/src/blocs/orders_bloc_provider.dart';
import 'package:swappin/src/models/order.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/historic.dart';
import 'package:swappin/src/ui/status.dart';
import 'package:swappin/src/ui/widgets/no-products.dart';
import 'package:swappin/src/ui/widgets/notification-list-item.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  OrdersBloc _bloc;

  compareDate(dynamic finalDate) {
    final difference = DateTime.now().difference(finalDate).inMinutes;
    if (difference <= 1) {
      return "$difference min";
    } else if (difference <= 59) {
      return "$difference mins";
    } else {
      final difference = DateTime.now().difference(finalDate).inHours;
      if (difference <= 1) {
        return "$difference hora";
      } else {
        return "$difference horas";
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = OrdersBlocProvider.of(context);
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
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              "assets/icons/black/arrow_left_1.png",
              width: 10.0,
            ),
          ),
        ),
        title: Text(
          "Meus Pedidos",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Color(
              0xFF00BFB2,
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoricScreen(),
              ),
            ),
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/icons/black/clock.png",
                width: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment(0.0, 0.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: StreamBuilder(
          stream: _bloc.getNotifications(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data.documents;
              List<Order> statusListener = _bloc.mapToList(docList: docs);
              if (statusListener.isNotEmpty) {
                statusListener
                    .sort((b, a) => a.finalDate.compareTo(b.finalDate));
                return buildList(statusListener);
              } else {
                return NoProductsScreen();
              }
            } else {
              return LoaderScreen();
            }
          },
        ),
      ),
    );
  }

  ListView buildList(List<Order> statusListener) {
    return ListView.builder(
      itemCount: statusListener.length,
      itemBuilder: (BuildContext context, int index) {
        return FlatButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StatusScreen(
                code: statusListener[index].code,
              ),
            ),
          ),
          child: Column(
            children: <Widget>[
              NotificationListItem(
                code: statusListener[index].code,
                storeName: statusListener[index].storeName,
                finalDate: compareDate(statusListener[index].finalDate),
                status: statusListener[index].status,
                total: statusListener[index].total.toDouble(),
                storePhoto: statusListener[index].storePhoto,
                productsList: statusListener[index].productList,
                amountList: statusListener[index].amountList,
              ),
              Container(
                child: Divider(),
              ),
            ],
          ),
        );
      },
    );
  }
}

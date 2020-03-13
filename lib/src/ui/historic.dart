import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swappin/src/blocs/orders_bloc.dart';
import 'package:swappin/src/blocs/orders_bloc_provider.dart';
import 'package:swappin/src/models/order.dart';
import 'package:swappin/src/ui/widgets/empty.dart';
import 'package:swappin/src/ui/widgets/historic-item.dart';
import 'package:swappin/src/ui/animations/loader.dart';

class HistoricScreen extends StatefulWidget {
  @override
  _HistoricScreenState createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  OrdersBloc _bloc;
  final dateFormat = new DateFormat('dd-MM-yyyy');
  final hourFormat = new DateFormat('hh:mm');

  compareDate(dynamic finalDate) {
    final difference = DateTime.now().difference(finalDate).inMinutes;
    if (difference <= 1) {
      return "Há $difference min";
    } else if (difference <= 59) {
      return "Há $difference mins";
    } else {
      final difference = DateTime.now().difference(finalDate).inHours;
      if (difference <= 1) {
        return "Há $difference hora";
      } else {
        return "Há $difference horas";
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
          "Meus Histórico",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Color(
              0xFF00BFB2,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: _bloc.userHistoric(),
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
                return EmptyScreen(
                  message: "Ooops, parece que você nunca comprou nada!\nbora fazer a primeira comprinha?",
                  image: "products",
                );
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
        String date = dateFormat.format(statusListener[index].finalDate);
        String hour = hourFormat.format(statusListener[index].finalDate);
        return HistoricListItem(
          storeName: statusListener[index].storeName,
          storeAdress: statusListener[index].storeAdress,
          storePhoto: statusListener[index].storePhoto,
          code: statusListener[index].code,
          note: statusListener[index].note,
          method: statusListener[index].method,
          initialDate: statusListener[index].initialDate,
          finalDate: date + " às " + hour,
          status: statusListener[index].status,
          productList: statusListener[index].productList,
          priceList: statusListener[index].priceList,
          amountList: statusListener[index].amountList,
          total: statusListener[index].total.toDouble(),
        );
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/orders_bloc.dart';
import 'package:swappin/src/blocs/orders_bloc_provider.dart';
import 'package:swappin/src/models/order.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/products.dart';
import 'package:swappin/src/ui/rating.dart';
import 'package:swappin/src/ui/widgets/no-products.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/score-stars.dart';

class StatusScreen extends StatefulWidget {
  final String code;

  StatusScreen({Key key, this.code}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState(code: code);
}

class _StatusScreenState extends State<StatusScreen> {
  OrdersBloc _bloc;
  String code;

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

  _StatusScreenState({this.code});

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
        backgroundColor: Color(0xFFF1F4F5),
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Image.asset(
            "assets/icons/black/arrow_left_1.png",
            width: 10.0,
          ),
        ),
        title: Text(
          "Status do Pedido",
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
        color: Color(0xFFF1F4F5),
        child: StreamBuilder(
          stream: _bloc.getNotifications(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data.documents;
              List<Order> orderList = _bloc.mapToList(docList: docs);
              if (orderList.isNotEmpty) {
                orderList.sort((b, a) => a.finalDate.compareTo(b.finalDate));
                return orderListBuilder(orderList);
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

  Widget orderListBuilder(List<Order> orderList) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Products(
                  store: orderList[0].storeName,
                  photo: orderList[0].storePhoto,
                  adress: orderList[0].storeAdress,
                  score: orderList[0].storeScore,
                  distance: 0,
                  delivery: "",
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
            height: 110,
            child: Row(
              children: <Widget>[
                Container(
                  width: 78.0,
                  height: 78.0,
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {},
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
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(color: Colors.white, width: 4.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                  orderList[0].storePhoto,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ScoreStars(score: orderList[0].storeScore),
                        Container(
                          child: Text(
                            orderList[0].storeName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(
                                0xFF444444,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/icons/black/home.png",
                                  width: 13.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  orderList[0].storeAdress,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    fontFamily: 'Quicksand',
                                    color: Color(0x88000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(bottom: 20),
            child: statusBuild(orderList[0].status)),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x44333333),
                  blurRadius: 15.0,
                  // has the effect of softening the shadow
                  spreadRadius: 4.0,
                  // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    10.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 60),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Resumo',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Código: ",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFAAAAAA),
                                    ),
                                  ),
                                  Text(
                                    orderList[0].code,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                              itemCount: orderList[0].productList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "${orderList[0].amountList[index].toString()}   ",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF666666),
                                            ),
                                          ),
                                          Text(
                                            orderList[0].productList[index],
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF666666),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "R\$${orderList[0].priceList[index].toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Método de Pagamento',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Text(
                                orderList[0].method,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Text(
                                "R\$${orderList[0].total.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF999999),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: _bloc.verifyOrderStatus(currentUserEmail, code),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> docs = snapshot.data.documents;
                        List<Order> statusListener =
                            _bloc.mapToList(docList: docs);
                        if (statusListener.isNotEmpty) {
                          statusListener.sort(
                              (b, a) => a.finalDate.compareTo(b.finalDate));
                          return buttonBuild(statusListener);
                        } else {
                          return Text("");
                        }
                      } else {
                        return Text("Nenhum pedido realizado.");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonBuild(List<Order> orderList) {
    if (orderList[0].status == "3") {
      return Container(
        alignment: Alignment.bottomCenter,
        child: SwappinButton(
          onPressed: () {
            print(orderList[0].productList);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RatingScreen(
                  storeName: orderList[0].storeName,
                  storeAdress: orderList[0].storeAdress,
                  storePhoto: orderList[0].storePhoto,
                  storeScore: orderList[0].storeScore,
                  code: orderList[0].code,
                  photoURL: orderList[0].photo,
                  note: orderList[0].note,
                  method: orderList[0].method,
                  initialDate: orderList[0].initialDate,
                  finalDate: orderList[0].finalDate.toString(),
                  total: orderList[0].total,
                  productList: orderList[0].productList,
                  priceList: orderList[0].priceList,
                  amountList: orderList[0].amountList,
                ),
              ),
            );
          },
          child: Text(
            "Finalizar Pedido",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget statusBuild(String status) {
    if (status == "1") {
      return Column(
        children: <Widget>[
          Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Image.network(
                      "https://avocode.com/static/images/homepage/index/banner-1.png",
                      fit: BoxFit.fitHeight,
                      height: 160,
                      width: 160,
                    ),
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Hey, seu pedido foi realizado. Aguarde a confirmação.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else if (status == "2") {
      return Column(
        children: <Widget>[
          Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Image.network(
                      "https://mariawebtech.com/wp-content/uploads/2019/12/banner-2.png",
                      fit: BoxFit.fitHeight,
                      height: 160,
                      width: 160,
                    ),
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Que legal! O seu pedido foi aceito.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Image.network(
                      "https://cdn.dribbble.com/users/1128531/screenshots/4961572/cover.jpg",
                      fit: BoxFit.fitHeight,
                      height: 160,
                      width: 160,
                    ),
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Boas notícias: o seu pedido foi concluído!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    }
  }
}

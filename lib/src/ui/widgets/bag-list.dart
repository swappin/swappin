//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:swappin/main.dart';
//import 'package:swappin/src/app.dart';
//import 'package:swappin/src/blocs/bag_bloc.dart';
//import 'package:swappin/src/blocs/bag_bloc_provider.dart';
//import 'package:swappin/src/blocs/orders_bloc.dart';
//import 'package:swappin/src/blocs/orders_bloc_provider.dart';
//import 'package:swappin/src/models/bag.dart';
//import 'package:swappin/src/models/user.dart';
//import 'package:swappin/src/ui/coupon.dart';
//import 'package:swappin/src/ui/home.dart';
//import 'package:swappin/src/ui/notifications.dart';
//import 'package:swappin/src/ui/payment.dart';
//import 'package:swappin/src/ui/widgets/empty.dart';
//import 'package:swappin/src/ui/widgets/gradient_button.dart';
//
//class BagListScreen extends StatefulWidget {
//  final String userEmail;
//  final String paymentMethod;
//  final String paymentThumbnail;
//  final String paymentChange;
//
//  BagListScreen({
//    Key key,
//    @required this.userEmail,
//    this.paymentMethod,
//    this.paymentThumbnail,
//    this.paymentChange,
//  }) : super(key: key);
//
//  @override
//  _BagListScreenState createState() => _BagListScreenState(
//        userEmail: userEmail,
//        paymentMethod: paymentMethod,
//        paymentThumbnail: paymentThumbnail,
//        paymentChange: paymentChange,
//      );
//}
//
//class _BagListScreenState extends State<BagListScreen> {
//  BagBloc _bloc;
//  OrdersBloc _ordersBloc;
//  String userEmail;
//  List<String> productList = List();
//  List<int> amountList = List();
//  List<double> priceList = List();
//  List<double> totalList = List();
//  double coupon = 10.0;
//  Future<double> _total;
//  double total = 0.0;
//  String paymentMethod;
//  String paymentThumbnail;
//  String paymentChange;
//  ScrollPhysics physics = ScrollPhysics();
//
//  _BagListScreenState({
//    this.userEmail,
//    this.paymentMethod,
//    this.paymentThumbnail,
//    this.paymentChange,
//  });
//
//  verifyAmount(int amount) {
//    if (amount <= 1) {
//      return Icon(Icons.delete);
//    } else {
//      return Text("-");
//    }
//  }
//
//  Future<double> getTotalPrice() async {
//    QuerySnapshot querySnapshot = await Firestore.instance
//        .collection('users')
//        .document('andre@swappin.io')
//        .collection('userOrders')
//        .where('price')
//        .getDocuments();
//    var orderList = querySnapshot.documents;
//    List<double> priceList = List();
//
//    orderList.asMap().forEach((index, data) {
//      priceList.add(data['price']);
//    });
//    return priceList.reduce((a, b) => a + b);
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _total = getTotalPrice();
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//
//    _total = getTotalPrice();
//    _bloc = BagBlocProvider.of(context);
//    _ordersBloc = OrdersBlocProvider.of(context);
//  }
//
//  @override
//  void dispose() {
//    _bloc.dispose();
//    _ordersBloc.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      alignment: Alignment(0.0, 0.0),
//      child: StreamBuilder(
//        stream: _bloc.getBagItens(currentUserEmail),
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasData) {
//            List<DocumentSnapshot> docs = snapshot.data.documents;
//            List<Bag> bagListItens = _bloc.mapToList(docList: docs);
//
////            List<double> sumList = List();
////            bagListItens.asMap().forEach((index, data){
////              sumList.add(data.price);
////            });
////            this.initialTotal = sumList.reduce((a, b) => a + b);
//            if (bagListItens.isNotEmpty) {
//              return buildList(bagListItens);
//            } else {
//              return EmptyScreen();
//            }
//          } else {
//            return CircularProgressIndicator();
//          }
//        },
//      ),
//    );
//  }
//
//  Column buildList(List<Bag> bagList) {
//    return Column(
//      children: <Widget>[
//        Expanded(
//          child: ListView.builder(
//            physics: physics,
//            shrinkWrap: true,
//            itemCount: bagList.length,
//            itemBuilder: (BuildContext context, int index) {
//              if (amountList.length < bagList.length &&
//                  priceList.length < bagList.length) {
//                productList.add(bagList[index].productName);
//                priceList.add(bagList[index].price);
//                amountList.add(bagList[index].amount);
//                totalList.add(amountList[index] * priceList[index]);
//                total = totalList.reduce((a, b) => a + b);
//              }
//              return Container(
//                decoration: BoxDecoration(
//                  border: Border(
//                    bottom: BorderSide(
//                      color: Color(0x22777777),
//                      width: 1.0,
//                    ),
//                  ),
//                ),
//                height: 110.0,
//                child: Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: SizedBox(
//                    height: 100,
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        AspectRatio(
//                          aspectRatio: 1.0,
//                          child: Container(
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(18.0),
//                              image: DecorationImage(
//                                image: NetworkImage(bagList[index].photo),
//                                fit: BoxFit.fill,
//                              ),
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          child: Container(
//                            padding:
//                                const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Text(
//                                  '${bagList[index].productName}',
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                  style: const TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                  ),
//                                ),
//                                Text(
//                                  'Loja: ${bagList[index].storeName}',
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                  style: const TextStyle(
//                                    fontSize: 12.0,
//                                    color: Colors.black54,
//                                  ),
//                                ),
//                                Text(
//                                  'R\$${bagList[index].price.toStringAsFixed(2)}',
//                                  style: const TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 12.0,
//                                    color: Colors.black87,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        Container(
//                          child: Row(
//                            children: <Widget>[
//                              Container(
//                                height: double.infinity,
//                                width: 40.0,
//                                child: FlatButton(
//                                  onPressed: () {
//                                    amountList[index]--;
//                                    totalList[index] = amountList[index] *
//                                        bagList[index].price;
//                                    _bloc.updateProductAmount(
//                                        "andre@swappin.io",
//                                        bagList[index].code,
//                                        amountList[index],
//                                        totalList[index]);
//                                    if (bagList[index].amount <= 1) {
//                                      _confirmDelete(
//                                          context,
//                                          bagList[index].code,
//                                          index,
//                                          bagList[index].price);
//                                    }
//                                    setState(() {
//                                      total = totalList.reduce((a, b) => a + b);
//                                    });
//                                  },
//                                  child: verifyAmount(bagList[index].amount),
//                                ),
//                              ),
//                              Container(
//                                alignment: Alignment.center,
//                                width: 20.0,
//                                child: Text(
//                                  bagList[index].amount.toString(),
//                                ),
//                              ),
//                              Container(
//                                height: double.infinity,
//                                width: 40.0,
//                                child: FlatButton(
//                                  onPressed: () {
//                                    amountList[index]++;
//                                    totalList[index] = amountList[index] *
//                                        bagList[index].price;
//                                    _bloc.updateProductAmount(
//                                        "andre@swappin.io",
//                                        bagList[index].code,
//                                        amountList[index],
//                                        totalList[index]);
//                                    setState(() {
//                                      total = totalList.reduce((a, b) => a + b);
//                                    });
//                                  },
//                                  child: Text("+"),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              );
//            },
//          ),
//        ),
//        Container(
//          height: 270.0,
//          width: double.infinity,
//          padding: EdgeInsets.all(10.0),
//          decoration: BoxDecoration(
//            color: Colors.white,
//            boxShadow: [
//              BoxShadow(
//                color: Color(0x66333333),
//                blurRadius: 20.0, // has the effect of softening the shadow
//                spreadRadius: 5.0, // has the effect of extending the shadow
//                offset: Offset(
//                  10.0, // horizontal, move right 10
//                  10.0, // vertical, move down 10
//                ),
//              )
//            ],
//          ),
//          child: FutureBuilder<double>(
//            future: _total,
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                if (totalList.reduce((a, b) => a + b) == snapshot.data) {
//                  total = snapshot.data;
//                } else {
//                  total = totalList.reduce((a, b) => a + b);
//                }
//                if (paymentMethod != null) {
//                  return Container(
//                    child: Column(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
//                          child: Column(
//                            children: <Widget>[
////                              ListTile(
////                                title: Text('Cupom de Desconto'),
////                                onTap: () {
////                                  Navigator.push(
////                                    context,
////                                    MaterialPageRoute(
////                                      builder: (context) => CouponScreen(),
////                                    ),
////                                  );
////                                },
////                                trailing: Icon(
////                                  Icons.description,
////                                  size: 16.0,
////                                ),
////                              ),
//                              ListTile(
//                                title: Text('Método de Pagamento'),
//                                subtitle: Text(paymentMethod),
//                                onTap: () {
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) =>
//                                            PaymentScreen(total: total),
//                                      ));
//                                },
//                                trailing: Image.network(
//                                  paymentThumbnail,
//                                  width: 40.0,
//                                ),
//                              ),
//                              ListTile(
//                                title: Text('Resumo'),
//                                subtitle: Column(
//                                  children: <Widget>[
//                                    Row(
//                                      children: <Widget>[
//                                        Expanded(child: Text("Subtotal")),
//                                        Text("R\$${total.toStringAsFixed(2)}"),
//                                      ],
//                                    ),
////                                  Row(
////                                    children: <Widget>[
////                                      Expanded(
////                                          child: Text("Cupom de Desconto")),
////                                      Text("-R\$${coupon.toStringAsFixed(2)}"),
////                                    ],
////                                  ),
//                                    Container(
//                                      margin: EdgeInsets.only(top: 10.0),
//                                      child: Row(
//                                        children: <Widget>[
//                                          Expanded(
//                                              child: Text(
//                                            "Total",
//                                            style: TextStyle(
//                                              fontSize: 18.0,
//                                              fontWeight: FontWeight.bold,
//                                            ),
//                                          )),
//                                          Text(
//                                            "R\$${(total - coupon).toStringAsFixed(2)}",
//                                            style: TextStyle(
//                                              fontSize: 18.0,
//                                              fontWeight: FontWeight.bold,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                                onTap: () {},
//                              ),
//                            ],
//                          ),
//                        ),
//                        GradientButton(
//                          onPressed: () {
//                            String code;
//                            String photo;
//                            String storeName;
//                            String adress;
//                            String note;
//                            num price;
//                            num amountFinal;
//                            num totalFinal;
//                            bagList.asMap().forEach((index, data) {
//                              code = data.code;
//                              photo = data.photo;
//                              storeName = data.storeName;
//                              adress = data.adress;
//                              note = data.note;
//                              price = data.price;
//                              amountFinal = amountList[index];
//                              totalFinal = totalList[index];
//                            });
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => NotificationScreen(),
//                              ),
//                            );
//                            _ordersBloc.orderProducts(
//                              code,
//                              productList,
//                              totalList,
//                              amountList,
//                              photo,
//                              currentUserEmail,
//                              storeName,
//                              adress,
//                              note,
//                              paymentMethod,
//                              totalFinal,
//                            );
//                            bagList.asMap().forEach((index, data) {
//                              _bloc.removeBagItem(
//                                  userEmail, bagList[index].code);
//                            });
//                          },
//                          child: Text(
//                            "Finalizar Pedido",
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 18.0),
//                          ),
//                        ),
//                      ],
//                    ),
//                  );
//                } else {
//                  return Container(
//                    child: Column(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
//                          child: Column(
//                            children: <Widget>[
////                              ListTile(
////                                title: Text('Cupom de Desconto'),
////                                onTap: () {
////                                  Navigator.push(
////                                    context,
////                                    MaterialPageRoute(
////                                      builder: (context) => CouponScreen(),
////                                    ),
////                                  );
////                                },
////                                trailing: Text(
////                                  "Selecionar",
////                                  style: TextStyle(
////                                    color: Color(0xFF05A9C7),
////                                  ),
////                                ),
////                              ),
//                              ListTile(
//                                title: Text('Método de Pagamento'),
//                                onTap: () {
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) =>
//                                            PaymentScreen(total: total),
//                                      ));
//                                },
//                                trailing: Text(
//                                  "Selecionar",
//                                  style: TextStyle(
//                                    color: Color(0xFF05A9C7),
//                                  ),
//                                ),
//                              ),
//                              ListTile(
//                                title: Text('Resumo'),
//                                subtitle: Column(
//                                  children: <Widget>[
//                                    Row(
//                                      children: <Widget>[
//                                        Expanded(child: Text("Subtotal")),
//                                        Text("R\$${total.toStringAsFixed(2)}"),
//                                      ],
//                                    ),
//                                    Row(
//                                      children: <Widget>[
//                                        Expanded(
//                                            child: Text("Cupom de Desconto")),
//                                        Text(
//                                            "-R\$${coupon.toStringAsFixed(2)}"),
//                                      ],
//                                    ),
//                                    Container(
//                                      margin: EdgeInsets.only(top: 10.0),
//                                      child: Row(
//                                        children: <Widget>[
//                                          Expanded(
//                                              child: Text(
//                                            "Total",
//                                            style: TextStyle(
//                                              fontSize: 18.0,
//                                              fontWeight: FontWeight.bold,
//                                            ),
//                                          )),
//                                          Text(
//                                            "R\$${(total - coupon).toStringAsFixed(2)}",
//                                            style: TextStyle(
//                                              fontSize: 18.0,
//                                              fontWeight: FontWeight.bold,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                                onTap: () {},
//                              ),
//                            ],
//                          ),
//                        ),
//                        Container(
//                          width: double.infinity,
//                          height: 60.0,
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(30.0),
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Colors.grey[500],
//                                  offset: Offset(0.0, 1.5),
//                                  blurRadius: 1.5,
//                                ),
//                              ],
//                              color: Colors.grey),
//                          child: FlatButton(
//                            onPressed: () {},
//                            child: Text(
//                              "Finalizar Pedisdo",
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 18.0),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  );
//                }
//              } else {
//                return
//                  SizedBox(
//                    child: CircularProgressIndicator(),
//                    height: 200.0,
//                    width: 200.0,
//                  );
//              }
//            },
//          ),
//        ),
//      ],
//    );
//  }
//
//  Future<void> _confirmDelete(
//      BuildContext context, String code, int index, double price) {
//    return showDialog<void>(
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('Excluir Item'),
//          content:
//              const Text('Tem certeza que deseja remover este item da sacola?'),
//          actions: <Widget>[
//            Row(
//              children: <Widget>[
//                FlatButton(
//                  child: Text(
//                    'Cancelar',
//                    style: TextStyle(
//                      color: Colors.redAccent,
//                    ),
//                  ),
//                  onPressed: () {
//                    amountList[index] = 1;
//                    _bloc.updateProductAmount(
//                        "andre@swappin.io", code, 1, price);
//                    totalList[index] = amountList[index] * price;
//                    setState(() {
//                      total = totalList.reduce((a, b) => a + b);
//                    });
//                    Navigator.of(context).pop();
//                  },
//                ),
//                FlatButton(
//                  child: Text('Sim'),
//                  onPressed: () {
//                    setState(() {
//                      total = totalList.reduce((a, b) => a + b);
//                    });
//                    _bloc.removeBagItem("andre@swappin.io", code);
//                    Navigator.of(context).pop();
//                  },
//                ),
//              ],
//            ),
//          ],
//        );
//      },
//    );
//  }
//
////  _bloc.orderProducts(name, code, photo, userName, storeName, _noteController.text, price, amount);
//}

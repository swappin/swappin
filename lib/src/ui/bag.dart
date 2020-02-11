import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/bag_bloc.dart';
import 'package:swappin/src/blocs/bag_bloc_provider.dart';
import 'package:swappin/src/blocs/orders_bloc.dart';
import 'package:swappin/src/blocs/orders_bloc_provider.dart';
import 'package:swappin/src/models/bag.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/payment.dart';
import 'package:swappin/src/ui/widgets/no-products.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/widgets/no-products.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/score-stars.dart';

class BagScreen extends StatefulWidget {
  final String paymentMethod;
  final String paymentThumbnail;
  final String paymentChange;

  const BagScreen({
    Key key,
    @required this.paymentMethod,
    this.paymentThumbnail,
    this.paymentChange,
  }) : super(key: key);

  @override
  _BagScreenState createState() => _BagScreenState(
        paymentMethod: this.paymentMethod,
        paymentThumbnail: this.paymentThumbnail,
        paymentChange: this.paymentChange,
      );
}

class _BagScreenState extends State<BagScreen> {
  BagBloc _bloc;
  OrdersBloc _ordersBloc;
  String userEmail;
  String currentStoreName;
  String currentStoreAdress;
  String currentStorePhoto;
  num currentStoreScore;
  List<String> productList = List();
  List<int> amountList = List();
  List<double> priceList = List();
  List<double> totalList = List();
  double coupon = 10.0;
  Future<double> _total;
  double total = 0.0;
  String paymentMethod;
  String paymentThumbnail;
  String paymentChange;
  ScrollPhysics physics = ScrollPhysics();
  num amount = 1;

  _BagScreenState({
    this.paymentMethod,
    this.paymentThumbnail,
    this.paymentChange,
  });

  verifyAmount(int amount) {
    if (amount <= 1) {
      return Opacity(
        opacity: 0.5,
        child: Image.asset(
          "assets/icons/black/delete.png",
          width: 14,
        ),
      );
    } else {
      return Text(
        "-",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: Color(0xFF888888),
        ),
      );
    }
  }

  Future<double> getTotalPrice() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .document(currentUserEmail)
        .collection('userOrders')
        .where('price')
        .getDocuments();
    var orderList = querySnapshot.documents;
    List<double> priceList = List();

    orderList.asMap().forEach((index, data) {
      priceList.add(data['price']);
    });
    return priceList.reduce((a, b) => a + b);
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentStoreName = prefs.getString('storeName');
    currentStorePhoto = prefs.getString('storePhoto');
    currentStoreAdress = prefs.getString('storeAdress');
    currentStoreScore = prefs.getDouble('storeScore');
  }

  @override
  void initState() {
    super.initState();
    _total = getTotalPrice();
    getStringValuesSF();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BagBlocProvider.of(context);
    _ordersBloc = OrdersBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    _ordersBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F4F5),
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home(currentIndex: 0))),
          child: Image.asset(
            "assets/icons/black/arrow_left_1.png",
            width: 10.0,
          ),
        ),
        title: Text(
          "Minha Sacola",
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
        alignment: Alignment(0.0, 0.0),
        child: StreamBuilder(
          stream: _bloc.getBagItens(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data.documents;
              List<Bag> bagListItens = _bloc.mapToList(docList: docs);
              if (bagListItens.isNotEmpty) {
                return productsList(bagListItens);
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

  Widget productsList(List<Bag> productsList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
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
                                border:
                                    Border.all(color: Colors.white, width: 4.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      currentStorePhoto,
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
                            ScoreStars(score:
                            currentStoreScore),
                            Container(
                              child: Text(currentStoreName,
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
                                      '$currentStoreAdress',
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
              ListView.builder(
                physics: physics,
                shrinkWrap: true,
                itemCount: productsList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (amountList.length < productsList.length &&
                      priceList.length < productsList.length) {
                    productList.add(productsList[index].productName);
                    priceList.add(productsList[index].price);
                    amountList.add(productsList[index].amount);
                    totalList.add(amountList[index] * priceList[index]);
                    total = totalList.reduce((a, b) => a + b);
                  }
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0x22777777),
                          width: 1.0,
                        ),
                      ),
                    ),
                    height: 110.0,
                    child: Container(
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          productsList[index].photo),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 2.0, 0.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      productsList[index].productName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      productsList[index].note != null
                                          ? "Nenhuma observação"
                                          : productsList[index].note,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        fontFamily: 'Quicksand',
                                        color: Color(0x66000000),
                                      ),
                                    ),
                                    Text(
                                      'R\$${productsList[index].price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF00BFB2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(0.0),
                              height: 50.0,
                              margin: EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: double.infinity,
                                    width: 50.0,
                                    child: FlatButton(
                                      onPressed: () {
                                        amountList[index]--;
                                        totalList[index] = amountList[index] *
                                            productsList[index].price;
                                        _bloc.updateProductAmount(
                                            currentUserEmail,
                                            productsList[index].code,
                                            amountList[index],
                                            totalList[index]);
                                        if (amountList[index] < 1) {
                                          _confirmDelete(
                                              context,
                                              productsList[index].code,
                                              index,
                                              productsList[index].price);
                                          if (amountList[index] <= 0) {
                                            amountList[index]++;
                                          }
                                        }
                                        setState(() {
                                          total =
                                              totalList.reduce((a, b) => a + b);
                                        });
                                      },
                                      child: verifyAmount(
                                          productsList[index].amount),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 40.0,
                                    child: Text(
                                      productsList[index].amount.toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF888888),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: 40.0,
                                    child: FlatButton(
                                      onPressed: () {
                                        amountList[index]++;
                                        totalList[index] = amountList[index] *
                                            productsList[index].price;
                                        _bloc.updateProductAmount(
                                            currentUserEmail,
                                            productsList[index].code,
                                            amountList[index],
                                            totalList[index]);
                                        setState(() {
                                          total =
                                              totalList.reduce((a, b) => a + b);
                                        });
                                      },
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF888888),
                                        ),
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
                  );
                },
              ),
            ],
          ),
        )),
        Container(
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
                blurRadius: 15.0, // has the effect of softening the shadow
                spreadRadius: 4.0, // has the effect of extending the shadow
                offset: Offset(
                  0.0, // horizontal, move right 10
                  10.0, // vertical, move down 10
                ),
              )
            ],
          ),
          child: FutureBuilder<double>(
            future: _total,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (totalList.reduce((a, b) => a + b) == snapshot.data) {
                  total = snapshot.data;
                } else {
                  total = totalList.reduce((a, b) => a + b);
                }
                if (paymentMethod != null) {
                  return Container(
                    height: 300.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
                          child: Column(
                            children: <Widget>[
//                              ListTile(
//                                title: Text('Cupom de Desconto'),
//                                onTap: () {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => CouponScreen(),
//                                    ),
//                                  );
//                                },
//                                trailing: Icon(
//                                  Icons.description,
//                                  size: 16.0,
//                                ),
//                              ),
                              ListTile(
                                title: Text(
                                  'Método de Pagamento',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                subtitle: Text(
                                  paymentMethod,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentScreen(total: total),
                                      ));
                                },
                                trailing: Image.network(
                                  paymentThumbnail,
                                  width: 40.0,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Resumo',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          "Subtotal",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF666666),
                                          ),
                                        )),
                                        Text("R\$${total.toStringAsFixed(2)}"),
                                      ],
                                    ),
//                                  Row(
//                                    children: <Widget>[
//                                      Expanded(
//                                          child: Text("Cupom de Desconto")),
//                                      Text("-R\$${coupon.toStringAsFixed(2)}"),
//                                    ],
//                                  ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            "Total",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF666666),
                                            ),
                                          )),
                                          Text(
                                            "R\$${(total).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF666666),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 40),
                            alignment: Alignment.bottomCenter,
                            child: SwappinButton(
                              onPressed: () {
                                String code;
                                String photo;
                                String storeName;
                                String storeAdress;
                                String storePhoto;
                                num storeScore;
                                String note;
                                num price;
                                num amountFinal;
                                num totalFinal;
                                productsList.asMap().forEach((index, data) {
                                  code = data.code;
                                  photo = data.photo;
                                  storeName = currentStoreName;
                                  storeAdress = currentStoreAdress;
                                  storePhoto = currentStorePhoto;
                                  storeScore = currentStoreScore;
                                  note = data.note;
                                  price = data.price;
                                  amountFinal = amountList[index];
                                  totalFinal = totalList[index];
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(currentIndex: 3),
                                  ),
                                );
                                _ordersBloc.orderProducts(
                                  currentStoreName,
                                  currentStoreAdress,
                                  currentStorePhoto,
                                  currentStoreScore,
                                  code,
                                  productList,
                                  totalList,
                                  amountList,
                                  photo,
                                  note,
                                  paymentMethod,
                                  total,
                                );
                                productsList.asMap().forEach((index, data) {
                                  _bloc.removeBagItem(currentUserEmail,
                                      productsList[index].code);
                                });
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
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: 250,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
                          child: Column(
                            children: <Widget>[
//                              ListTile(
//                                title: Text('Cupom de Desconto'),
//                                onTap: () {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => CouponScreen(),
//                                    ),
//                                  );
//                                },
//                                trailing: Text(
//                                  "Selecionar",
//                                  style: TextStyle(
//                                    color: Color(0xFF05A9C7),
//                                  ),
//                                ),
//                              ),
                              ListTile(
                                title: Text(
                                  'Método de Pagamento',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentScreen(total: total),
                                      ));
                                },
                                trailing: Text(
                                  "Selecionar",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF00BFB2),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Resumo',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          "Subtotal",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF666666),
                                          ),
                                        )),
                                        Text(
                                          "R\$${total.toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF666666),
                                          ),
                                        ),
                                      ],
                                    ),
//                                    Row(
//                                      children: <Widget>[
//                                        Expanded(
//                                            child: Text("Cupom de Desconto")),
//                                        Text(
//                                            "-R\$${coupon.toStringAsFixed(2)}"),
//                                      ],
//                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            "Total",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF666666),
                                            ),
                                          )),
                                          Text(
                                            "R\$${total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF666666),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[500],
                                      offset: Offset(0.0, 1.5),
                                      blurRadius: 1.5,
                                    ),
                                  ],
                                  color: Colors.grey),
                              child: FlatButton(
                                onPressed: () {},
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
                            ),
                          ],
                        ))
                      ],
                    ),
                  );
                }
              } else {
                return Container(
                    height: 300,
                    child: Center(
                      child: SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(),
                      ),
                    ));
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, String code, int index, double price) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Item'),
          content:
              const Text('Tem certeza que deseja remover este item da sacola?'),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    amountList[index] = 1;
                    _bloc.updateProductAmount(currentUserEmail, code, 1, price);
                    totalList[index] = amountList[index] * priceList[index];
                    setState(() {
                      total = totalList.reduce((a, b) => a + b);
                    });
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    setState(() {
                      total = totalList.reduce((a, b) => a + b);
                    });
                    _bloc.removeBagItem(currentUserEmail, code);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

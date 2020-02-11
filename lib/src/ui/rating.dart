import 'package:flutter/material.dart';
import 'package:swappin/main.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/orders_bloc.dart';
import 'package:swappin/src/blocs/orders_bloc_provider.dart';
import 'package:swappin/src/blocs/stores_bloc_provider.dart';
import 'package:swappin/src/models/order.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/thanks.dart';
import 'package:swappin/src/ui/widgets/score-stars.dart';
import 'package:swappin/src/ui/widgets/store-card.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';

class RatingScreen extends StatefulWidget {
  final String storeName;
  final String storeAdress;
  final String storePhoto;
  final num storeScore;
  final String productName;
  final String code;
  final Widget photo;
  final String photoURL;
  final String note;
  final String method;
  final DateTime initialDate;
  final String finalDate;
  final String status;
  final List<dynamic> productList;
  final List<dynamic> priceList;
  final List<dynamic> amountList;
  final num total;

  RatingScreen({
    Key key,
    this.storeName,
    this.storeAdress,
    this.storePhoto,
    this.storeScore,
    this.productName,
    this.code,
    this.photo,
    this.photoURL,
    this.note,
    this.method,
    this.initialDate,
    this.finalDate,
    this.status,
    this.productList,
    this.priceList,
    this.amountList,
    this.total,
  }) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState(
        storeName: this.storeName,
        storeAdress: this.storeAdress,
        storePhoto: this.storePhoto,
        storeScore: this.storeScore,
        code: this.code,
        note: this.note,
        method: this.method,
        photoURL: this.photoURL,
        initialDate: this.initialDate,
        finalDate: this.finalDate,
        total: this.total,
        productList: this.productList,
        priceList: this.priceList,
        amountList: this.amountList,
      );
}

class _RatingScreenState extends State<RatingScreen> {
  OrdersBloc _ordersBloc;
  StoresBloc _storesBloc;
  String storeName;
  String storeAdress;
  String storePhoto;
  num storeScore;
  String code;
  String note;
  String method;
  String photoURL;
  DateTime initialDate;
  String finalDate;
  num total;
  List<dynamic> productList;
  List<dynamic> priceList;
  List<dynamic> amountList;
  Color buttonColor = Colors.grey;
  Color startColor1 = Colors.grey;
  Color startColor2 = Colors.grey;
  Color startColor3 = Colors.grey;
  Color startColor4 = Colors.grey;
  Color startColor5 = Colors.grey;
  bool hasScore = false;
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _npsController = TextEditingController();
  int storeReview = 0;
  int swappinNPS = 0;

  List<Color> npsColorList = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];
  List<Color> starColorList = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  _RatingScreenState(
      {this.storeName,
      this.storeAdress,
      this.storePhoto,
      this.storeScore,
      this.code,
      this.note,
      this.method,
      this.photoURL,
      this.initialDate,
      this.finalDate,
      this.total,
      this.productList,
      this.priceList,
      this.amountList});

  _getRating(int index) {
    setState(() {
      storeScore = index.toDouble();
      hasScore = true;
      switch (index) {
        case 1:
          starColorList = [
            Color(0xFF00BFB2),
            Colors.grey,
            Colors.grey,
            Colors.grey,
            Colors.grey,
          ];
          break;
        case 2:
          starColorList = [
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Colors.grey,
            Colors.grey,
            Colors.grey,
          ];
          break;
        case 3:
          starColorList = [
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Colors.grey,
            Colors.grey,
          ];
          break;
        case 4:
          starColorList = [
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Colors.grey,
          ];
          break;
        case 5:
          starColorList = [
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
            Color(0xFF00BFB2),
          ];
          break;
      }
    });
  }

  npsSelector(int index) {
    if (index == 1) {
      npsColorList = [
        Color(0xFF00BFB2),
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
    } else if (index == 2) {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
    } else if (index == 3) {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
    } else if (index == 4) {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
    } else if (index == 5) {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
    } else if (index == 6) {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
    } else if (index == 7) {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
    } else if (index == 8) {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Colors.grey,
        Colors.grey,
      ];
    } else if (index == 9) {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Colors.grey,
      ];
    } else {
      npsColorList = [
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
        Color(0xFF00BFB2),
      ];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ordersBloc = OrdersBlocProvider.of(context);
    _storesBloc = StoresBlocProvider.of(context);
  }

  @override
  void dispose() {
    _ordersBloc.dispose();
    _storesBloc.dispose();
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
          "Avaliação",
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
                builder: (context) => Home(currentIndex: 1),
              ),
            ),
            child: Text(
              "Depois",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Color(
                  0xFF00BFB2,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      StoreCard(storeName: storeName, storeAdress: storeAdress, storePhoto: storePhoto,),
                      Container(
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
                                  "Pedido: ",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFAAAAAA),
                                  ),
                                ),
                                Text(
                                  code,
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
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(productList.length);
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        amountList[index].toString(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF666666),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          productList[index],
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF666666),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "R\$${priceList[index]}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ),
                            Text(
                              "R\$$total",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xFF999999),
                              ),
                            ),
                          ],
                        ),
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
                              method,
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
                          margin: EdgeInsets.only(top: 35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Como foi a sua experiência?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Text(
                                'Escolha entre 1 e 5 estrelas para avaliar $storeName',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 50,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: ListView.builder(
                                      itemCount: starColorList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          width: 50,
                                          child: FlatButton(
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              storeReview = index + 1;
                                              _getRating(index + 1);
                                            },
                                            child: ShaderMask(
                                              shaderCallback: (rect) {
                                                return LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      starColorList[index],
                                                      starColorList[index],
                                                    ],
                                                    stops: [
                                                      0.5,
                                                      0.5
                                                    ]).createShader(
                                                    Rect.fromLTRB(
                                                        0, 0, 5, rect.height));
                                              },
                                              blendMode: BlendMode.srcATop,
                                              child: Image.asset(
                                                'assets/icons/black/star_favorite_1.png',
                                                width: 25,
                                                height: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        );
                                      })),
                              Container(
                                height: 120.0,
                                child: TextField(
                                  controller: _reviewController,
                                  maxLengthEnforced: false,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Faça uma observação...",
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Quicksand',
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),

                      /* NPS */
                      Container(
                          margin: EdgeInsets.only(top: 35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'O que achou da Swappin?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Text(
                                'De 1 a 10, qual é a chance de você indicar o nosso app para um amigo ou familiar?',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                height: 25,
                                alignment: Alignment.center,
                                child: ListView.builder(
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: 25,
                                      height: 25,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                        color: npsColorList[index],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          swappinNPS = index + 1;
                                          setState(() {
                                            npsSelector(index + 1);
                                          });
                                        },
                                        child: Text((index + 1).toString()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child:
                                Text(
                                  'Tem algo que podemos melhorar?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                              Container(
                                height: 120.0,
                                child: TextField(
                                  controller: _npsController,
                                  maxLengthEnforced: false,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Conte-nos tudo...",
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Quicksand',
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                child: hasScore != false
                    ? SwappinButton(
                        onPressed: () {
                          if (hasScore != false) {
                            _ordersBloc.registerOrders(
                                code,
                                productList,
                                priceList,
                                amountList,
                                currentUserName,
                                storeName,
                                storeAdress,
                                storePhoto,
                                note,
                                method,
                                total,
                                initialDate,
                                storeReview.toDouble(),
                                true,
                            );

                          print(storeName);
                          print(_reviewController.text);
                          print(code);
                          print(storeReview);
                            _ordersBloc.reviewStore(storeName, _reviewController.text, code, storeReview);
                            _ordersBloc.collectNPS(_npsController.text, swappinNPS);
                            print("BUYA");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ThanksScreen(
                                  userName: currentUserName,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Avaliar Pedido",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.0),
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Text(
                            "Avaliar Pedido",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

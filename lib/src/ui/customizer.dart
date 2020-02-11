import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swappin/src/blocs/bag_bloc.dart';
import 'package:swappin/src/blocs/bag_bloc_provider.dart';
import 'package:swappin/src/blocs/orders_bloc.dart';
import 'package:swappin/src/blocs/orders_bloc_provider.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';

class CustomizerScreen extends StatefulWidget {
  final String storeName;
  final String storeAdress;
  final String storePhoto;
  final double storeScore;
  final String productName;
  final String userName;
  final String code;
  final String photo;
  final String description;
  final num price;
  final num promotionPrice;
  final bool isPromotion;

  CustomizerScreen(
      {Key key,
      @required this.storeName,
      this.storeAdress,
      this.storePhoto,
      this.storeScore,
      this.productName,
      this.userName,
      this.code,
      this.photo,
      this.description,
      this.price,
      this.promotionPrice,
        this.isPromotion,
      })
      : super(key: key);

  @override
  _CustomizerScreenState createState() => _CustomizerScreenState(
      storeName: this.storeName,
      storeAdress: this.storeAdress,
      storePhoto: this.storePhoto,
      storeScore: this.storeScore,
      productName: this.productName,
      code: this.code,
      photo: this.photo,
      userName: this.userName,
      description: this.description,
      price: this.price,
      promotionPrice: this.promotionPrice,
    isPromotion: this.isPromotion,
  );
}

class _CustomizerScreenState extends State<CustomizerScreen> {
  TextEditingController _noteController = TextEditingController();
  OrdersBloc _bloc;
  BagBloc _bagBloc;
  String userName;
  String storeName;
  String storeAdress;
  String storePhoto;
  double storeScore;
  String productName;
  String code;
  String photo;
  String description;
  num price;
  num promotionPrice;
  num amount = 1;
  bool isPromotion;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool hasProducts = false;

  String currentStore;

  _CustomizerScreenState({
    this.storeName,
    this.storeAdress,
    this.storePhoto,
    this.storeScore,
    this.productName,
    this.code,
    this.photo,
    this.userName,
    this.description,
    this.price,
    this.promotionPrice,
    this.isPromotion,
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

  addStringToSF(String storeName, String storeAdress, String storePhoto,
      double storeScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('storeName', storeName);
    prefs.setString('storeAdress', storeAdress);
    prefs.setString('storePhoto', storePhoto);
    prefs.setDouble('storeScore', storeScore);
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentStore = prefs.getString('storeName');
  }

  @override
  void initState() {
    super.initState();
    getStringValuesSF();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = OrdersBlocProvider.of(context);
    _bagBloc = BagBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    _bagBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                this._backgroundImage(),
                Positioned(
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    leading: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        "assets/icons/white/arrow_left_1.png",
                        width: 10.0,
                      ),
                    ),
                    title: Text(
                      storeName,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 30.0,
                    alignment: Alignment.topLeft,
                    child: Text(
                      productName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color(0xFF444444),
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                    alignment: Alignment.topLeft,
                    child: isPromotion ? Row(
                      children: <Widget>[
                        Text(
                          "R\$${promotionPrice.toStringAsFixed(2).toString()}  ",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF00BFB2),
                          ),
                        ),
                        Text(
                          "R\$${price.toStringAsFixed(2).toString()}",
                          style: TextStyle(
                            fontSize: 15.0,

                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            color: Color(0xFFAAAAAA),
                          ),
                        ),
                      ],
                    ) : Text(
                      "R\$${price.toStringAsFixed(2).toString()}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color(0xFF00BFB2),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Container(
                    height: 140.0,
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            child: Text(
                              "Observação:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xFF444444),
                              ),
                            ),
                          ),
                          Container(
                            height: 200.0,
                            padding: EdgeInsets.only(bottom: 40.0),
                            child: TextField(
                              controller: _noteController,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 120.0,
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x11135252),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: Offset(
                0.0,
                0.0,
              ),
            )
          ],
        ),
        child: Row(
          children: <Widget>[
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
                        setState(() {
                          amount--;
                        });
                        if (amount <= 1) {
                          _confirmDelete(context);
                        }
                      },
                      child: verifyAmount(amount),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 40.0,
                    child: Text(
                      amount.toString(),
                      style: TextStyle(
                        fontSize: 16,
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
                        setState(() {
                          amount++;
                        });
                      },
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontSize: 16,
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
            Builder(
              builder: (context) => Expanded(
                child: SwappinButton(
                  onPressed: () {
                    print(currentStore);
                    if (currentStore != null) {
                      if (currentStore == storeName) {
                        _bagBloc.submitToBag(
                          storeName,
                          storeAdress,
                          storePhoto,
                          storeScore,
                            productName,
                            _noteController.text,
                            photo,
                            isPromotion ? promotionPrice.toDouble() : price.toDouble(),
                            amount,
                        );
                        Navigator.pop(context);
                      } else {
                        showMenu();
                      }
                    } else {
                      addStringToSF(storeName, storeAdress, storePhoto, storeScore);
                      _bagBloc.submitToBag(
                        storeName,
                        storeAdress,
                        storePhoto,
                        storeScore,
                        productName,
                        _noteController.text,
                        photo,
                        isPromotion ? promotionPrice.toDouble() : price.toDouble(),
                        amount,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Adicionar",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            isPromotion ? "R\$${(amount * promotionPrice).toStringAsFixed(2)}" : "R\$${(amount * price).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showMenu() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: (56 * 6).toDouble(),
          child: Container(
            padding: EdgeInsets.all(30.0),
            color: Colors.white,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 90.0,
                    child: Text(
                      "Já existe um pedido em andamento em $currentStore.",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                  Container(
                    height: 90.0,
                    child: Text(
                      "Você só pode comprar produtos de uma loja por vez. "
                      "Deseja esvaziar a sacola para adicionar os produtos de $storeName?",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SwappinButton(
                    onPressed: () {
                      addStringToSF(storeName, storeAdress, storePhoto, storeScore);
                      _bagBloc.clearBag(
                        storeName,
                        storeAdress,
                        storePhoto,
                        storeScore,
                        productName,
                        _noteController.text,
                        photo,
                        isPromotion ? promotionPrice.toDouble() : price.toDouble(),
                        amount);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      child: Text(
                        "Esvaziar Sacola e Adicionar",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    height: 20.0,
                    child: Center(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF00BFB2),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _backgroundImage() {
    return Stack(
      children: <Widget>[
        Container(
          height: 360.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(40.0),
              bottomRight: const Radius.circular(40.0),
            ),
            image: DecorationImage(
              image: NetworkImage(photo),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 360.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(40.0),
              bottomRight: const Radius.circular(40.0),
            ),
            color: Color(0x66000000),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(BuildContext context) {
    return showDialog<void>(
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
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Navigator.of(context).pop();
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

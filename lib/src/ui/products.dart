import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/products_bloc.dart';
import 'package:swappin/src/blocs/products_bloc_provider.dart';
import 'package:swappin/src/models/product.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/customizer.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/widgets/no-products.dart';
import 'package:swappin/src/ui/widgets/navigation-bar.dart';
import 'package:swappin/src/ui/widgets/no-stores.dart';
import 'package:swappin/src/ui/widgets/product-list-item.dart';
import 'package:swappin/src/ui/widgets/score-stars.dart';

class Products extends StatefulWidget {
  final String store;
  final String adress;
  final String photo;
  final String delivery;
  final num score;
  final num distance;

  Products(
      {Key key,
      @required this.store,
      this.adress,
      this.photo,
      this.delivery,
      this.score,
      this.distance})
      : super(key: key);

  @override
  _ProductsState createState() => _ProductsState(
      store: this.store,
      adress: this.adress,
      photo: this.photo,
      delivery: this.delivery,
      score: this.score,
      distance: this.distance);
}

class _ProductsState extends State<Products> {
  ProductsBloc _bloc;

  String store;
  String adress;
  String photo;
  String delivery;
  num score;
  num distance;
  bool hasPromotion = false;

  _ProductsState(
      {this.store,
      this.adress,
      this.photo,
      this.delivery,
      this.score,
      this.distance});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = ProductsBlocProvider.of(context);
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
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home(currentIndex: 0))),
          child: Image.asset(
            "assets/icons/black/arrow_left_1.png",
            width: 10.0,
          ),
        ),
        title: Text(
          store,
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
        padding: EdgeInsets.symmetric(vertical: 0),
        alignment: Alignment.topCenter,
        child: StreamBuilder(
          stream: _bloc.productsList(store),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data.documents;
              List<Product> productsList = _bloc.mapToList(docList: docs);
              if (productsList.isNotEmpty) {
                productsList.forEach((data){
                  if(data.isPromotion){
                    hasPromotion = false;
                  }
                });
                return buildList(productsList);
              } else {
                return NoStoresScreen();
              }
            } else {
              return LoaderScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }

  Widget buildList(List<Product> productsList) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 110,
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
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
                                  photo,
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
                        ScoreStars(score: score),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  "assets/icons/black/home.png",
                                  width: 13,
                                ),
                              ),
                              Container(
                                width: 4,
                              ),
                              Container(
                                child: Text(
                                  '$adress',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
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
          hasPromotion != false ?
          Container() : Column(
            children: <Widget>[
              Container(
                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                 width: double.infinity,
                 height: 45.0,
                 child: Text(
                   "Promoções",
                   style: TextStyle(
                     fontSize: 14.0,
                     fontWeight: FontWeight.bold,
                     fontFamily: 'Poppins',
                     color: Color(0xFF444444),
                   ),
                 ),
               ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 180.0,
                width: double.infinity,
                child: promotionList(productsList),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            height: 45.0,
            child: Text(
              "Produtos",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Color(0xFF444444),
              ),
            ),
          ),
          productsListBuild(productsList),
        ],
      ),
    );
  }

  ListView productsListBuild(List<Product> productsList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productsList.length,
        itemBuilder: (BuildContext context, int index) {
          if (productsList[index].isEnable != false) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 100.0,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xEEE9FF))),
                  ),
                  child: FlatButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomizerScreen(
                            storeName: store,
                            storeAdress: adress,
                            storePhoto: photo,
                            storeScore: score,
                            productName: productsList[index].name,
                            code: productsList[index].code,
                            photo: productsList[index].photo,
                            userName: currentUserName,
                            description: productsList[index].description,
                            price: productsList[index].price,
                            promotionPrice: productsList[index].promotionPrice,
                            isPromotion: productsList[index].isPromotion,
                          ),
                        ),
                      );
                    },
                    child: ProductListItem(
                      photo: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          image: DecorationImage(
                            image: NetworkImage(productsList[index].photo),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      name: productsList[index].name,
                      price: productsList[index].price.toDouble(),
                      description: productsList[index].description,
                    ),
                  ),
                ),
                Container(
                  child: Divider(),
                ),
              ],
            );
          } else {
            return null;
          }
        });
  }

  ListView promotionList(List<Product> productsList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: productsList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        if (productsList[index].isPromotion == true) {
          return FlatButton(
            padding: EdgeInsets.all(0.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomizerScreen(
                    storeName: store,
                    storeAdress: adress,
                    storePhoto: photo,
                    storeScore: score,
                    productName: productsList[index].name,
                    code: productsList[index].code,
                    photo: productsList[index].photo,
                    userName: currentUserName,
                    description: productsList[index].description,
                    price: productsList[index].price,
                    promotionPrice: productsList[index].promotionPrice,
                    isPromotion: productsList[index].isPromotion,
                  ),
                ),
              );
            },
            child: Container(
              height: 180.0,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(productsList[index].photo),
                          ),
                        ),
                        margin: EdgeInsets.only(right: 10.0),
                        padding: EdgeInsets.all(10.0),
                        height: 120.0,
                        width: 120.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          color: Color(0x66000000),
                        ),
                        margin: EdgeInsets.only(right: 10.0),
                        padding: EdgeInsets.all(10.0),
                        height: 120.0,
                        width: 120.0,
                      ),
                      Container(
                        height: 120.0,
                        width: 120.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "R\$${productsList[index].price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFCCCCCC),
                                  decoration: TextDecoration.lineThrough,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "R\$${productsList[index].promotionPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    height: 60.0,
                    width: 120.0,
                    child: Text(
                      productsList[index].name,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color(0xFF333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

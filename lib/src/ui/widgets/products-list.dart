//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:swappin/main.dart';
//import 'package:swappin/src/app.dart';
//import 'package:swappin/src/blocs/products_bloc.dart';
//import 'package:swappin/src/blocs/products_bloc_provider.dart';
//import 'package:swappin/src/models/product.dart';
//import 'package:swappin/src/ui/home.dart';
//import 'package:swappin/src/ui/orders.dart';
//import 'package:swappin/src/ui/widgets/product-list-item.dart';
//
//class ProductsListScreen extends StatefulWidget {
//  final String store;
//  final String adress;
//
//  ProductsListScreen({Key key, @required this.store, this.adress})
//      : super(key: key);
//
//  @override
//  _ProductsListState createState() {
//    return _ProductsListState(store: this.store, adress: this.adress);
//  }
//}
//
//class _ProductsListState extends State<ProductsListScreen> {
//  ProductsBloc _bloc;
//  String store;
//  String adress;
//
//  _ProductsListState({this.store, this.adress});
//
//  getStoreName(String store) {
//    store = store;
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    _bloc = ProductsBlocProvider.of(context);
//  }
//
//  @override
//  void dispose() {
//    _bloc.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Column(
//        children: <Widget>[
//          Container(
//            padding: EdgeInsets.all(10.0),
//            width: double.infinity,
//            height: 45.0,
//            child: Text(
//              "Promoções",
//              style: TextStyle(
//                  color: Color(0xFF555555),
//                  fontWeight: FontWeight.bold,
//                  fontSize: 18.0),
//            ),
//          ),
//          Container(
//            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
//            height: 125.0,
//            child: StreamBuilder(
//              stream: _bloc.productsList(store, true),
//              builder: (BuildContext context,
//                  AsyncSnapshot<QuerySnapshot> snapshot) {
//                if (snapshot.hasData) {
//                  List<DocumentSnapshot> docs = snapshot.data.documents;
//                  List<Product> productsListItens =
//                      _bloc.mapToList(docList: docs);
//                  if (productsListItens.isNotEmpty) {
//                    return promotionList(productsListItens);
//                  } else {
//                    print(productsListItens);
//                    return Text("Nenhum produto encontrado.");
//                  }
//                } else {
//                  return Text("Nenhum produto encontrado.");
//                }
//              },
//            ),
//          ),
//          Container(
//            width: double.infinity,
//            height: 45.0,
//            padding: EdgeInsets.all(10.0),
//            margin: EdgeInsets.only(bottom: 10.0),
//            child: Text(
//              "Produtos",
//              style: TextStyle(
//                  color: Color(0xFF555555),
//                  fontWeight: FontWeight.bold,
//                  fontSize: 18.0),
//            ),
//          ),
//          Expanded(
//            child: Container(
//              child: StreamBuilder(
//                stream: _bloc.productsList(store, false),
//                builder: (BuildContext context,
//                    AsyncSnapshot<QuerySnapshot> snapshot) {
//                  if (snapshot.hasData) {
//                    List<DocumentSnapshot> docs = snapshot.data.documents;
//                    List<Product> productsListItens =
//                        _bloc.mapToList(docList: docs);
//                    if (productsListItens.isNotEmpty) {
//                      return productList(productsListItens);
//                    } else {
//                      print(productsListItens);
//                      return Text("Nenhum produto encontrado.");
//                    }
//                  } else {
//                    return Text("Nenhum produto encontrado.");
//                  }
//                },
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//}

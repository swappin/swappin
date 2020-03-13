import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/products_bloc.dart';
import 'package:swappin/src/blocs/products_bloc_provider.dart';
import 'package:swappin/src/models/product.dart';
import 'package:swappin/src/ui/customizer.dart';
import 'package:swappin/src/ui/products.dart';
import 'package:swappin/src/ui/widgets/empty.dart';
import 'package:swappin/src/ui/widgets/navigation-bar.dart';
import 'package:swappin/src/ui/widgets/search-list-item.dart';
import 'package:diacritic/diacritic.dart';

class SearchScreen extends StatefulWidget {
  final String filter;
  SearchScreen({
    Key key,
  @required this.filter}) : super(key: key);
  @override
  _SearchListState createState() {
    return _SearchListState(
      filter: this.filter
    );
  }
}

String store;

class _SearchListState extends State<SearchScreen> {
  ProductsBloc _bloc;
  TextEditingController controller = TextEditingController();
  String filter;

  _SearchListState({this.filter});
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
  initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Image.asset(
            "assets/icons/black/arrow_left_1.png",
            width: 10.0,
          ),
        ),
        title: Text(
          "Pesquisar Produtos",
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
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: searchField(),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 30.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 40,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Próximos",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF444444),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Distância",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF00BFB2),
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
              Expanded(
                child: StreamBuilder(
                  stream: _bloc.searchProducts(filter),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> docs = snapshot.data.documents;
                      List<Product> productList =
                          _bloc.mapToList(docList: docs);
                      if (productList.isNotEmpty) {
                        //storesList.sort((a, b) => a.meters.compareTo(b.meters));
                        return buildList(productList);
                      } else {
                        return EmptyScreen(
                          message: "Que bad, não há nada por aqui!",
                          image: "products",
                        );
                      }
                    } else {
                      return EmptyScreen(
                        message: "Que bad, não há nada por aqui!",
                        image: "products",
                      );
                    }
                  },
                ),
              )
            ],
          )),
      bottomNavigationBar: NavigationBar(),
    );
  }

  ListView buildList(List<Product> productsList) {
    return ListView.builder(
      itemCount: productsList.length,
      itemBuilder: (BuildContext context, int index) {
        List<String> keywordList = [];
        productsList.asMap().forEach((index, data) {
          keywordList.add(productsList[index]
              .productKeywords
              .reduce((value, element) => value + ' ' + element));
        });
        return filter == null || filter == "" || filter.length < 3
            ? Container()
            : removeDiacritics(productsList[index].name.toLowerCase())
                        .contains(removeDiacritics(filter.toLowerCase())) ||
                    removeDiacritics(keywordList[index].toLowerCase())
                        .contains(removeDiacritics(filter.toLowerCase()))
                ? Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 5.0),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomizerScreen(
                                  storeName: productsList[index].storeName,
                                  storeAdress: productsList[index].storeAdress,
                                  storePhoto: productsList[index].storePhoto,
                                  storeScore:
                                      productsList[index].storeScore.toDouble(),
                                  productName: productsList[index].name,
                                  code: productsList[index].code,
                                  photo: productsList[index].photo,
                                  userName: currentUserName,
                                  description: productsList[index].description,
                                  price: productsList[index].price,
                                  promotionPrice:
                                      productsList[index].promotionPrice,
                                  isPromotion: productsList[index].isPromotion,
                                ),
                              ),
                            );
                          },
                          child: SearchListItem(
                            productPhoto: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(productsList[index].photo),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            productName: productsList[index].name,
                            productPrice: productsList[index].isPromotion
                                ? productsList[index].promotionPrice.toDouble()
                                : productsList[index].price.toDouble(),
                            storeName: productsList[index].storeName,
                            storeAdress: productsList[index].storeAdress,
                            distance:
                                productsList[index].distance.floor().toString(),
                          ),
                        ),
                      ),
                      Container(
                        child: Divider(),
                      ),
                    ],
                  )
                : Container();
      },
    );
  }

  Widget searchField() {
    return StreamBuilder(
      stream: _bloc.search,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          decoration: InputDecoration(
            icon: Opacity(
              opacity: 0.65,
              child: Image.asset(
                "assets/icons/black/search.png",
                width: 16.0,
              ),
            ),
            hintText: "Qual produto deseja?",
            border: InputBorder.none,
          ),
          controller: controller,
          cursorColor: Color(0xFF00BFB2),
          style: TextStyle(
            color: Color(0xFF00BFB2),
          ),
          cursorWidth: 3.0,
        );
      },
    );
  }
}

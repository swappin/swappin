//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:swappin/src/ui/products.dart';
//import 'package:swappin/src/ui/widgets/products-list.dart';
//import 'package:swappin/src/ui/widgets/store-list-item.dart';
//import '../../blocs/stores_bloc_provider.dart';
//import '../../models/store.dart';
//
//class FashionCategoryListScreen extends StatefulWidget {
//  String category;
//
//  FashionCategoryListScreen(this.category);
//  @override
//  _StoreListState createState() {
//    return _StoreListState(this.category);
//  }
//}
//
//String store;
//
//class _StoreListState extends State<FashionCategoryListScreen> {
//  StoresBloc _bloc;
//  String category;
//
//  _StoreListState(this.category);
//
//  getStoreName(String name) {
//    store = name;
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    _bloc = StoresBlocProvider.of(context);
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
//      alignment: Alignment(0.0, 0.0),
//      child: StreamBuilder(
//        stream: _bloc.storesList(category),
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasData) {
//            List<DocumentSnapshot> docs = snapshot.data.documents;
//            List<Store> storesList = _bloc.mapToList(docList: docs);
//            if (storesList.isNotEmpty) {
//              storesList.sort((a, b) => a.meters.compareTo(b.meters));
//              return buildList(storesList);
//            } else {
//              return Text("Nenhuma loja próxima ou aberta.");
//            }
//          } else {
//            return Text("Nenhuma loja próxima ou aberta.");
//          }
//        },
//      ),
//    );
//  }
//
//  CustomScrollView buildList(List<Store> storesList) {
//    return CustomScrollView(
//      slivers: <Widget>[
//        SliverAppBar(
//          leading: Icon(
//            Icons.person_outline,
//            color: Colors.white,
//            size: 32.0,
//          ),
//          title: Center(
//            child: Image.asset(
//              "assets/logo-appbar.png",
//              width: 100.0,
//            ),
//          ),
//          actions: <Widget>[
//            Padding(
//              padding: EdgeInsets.only(right: 10.0),
//              //Verificar no Futuro
//              child: Icon(
//                Icons.search,
//                color: Colors.white,
//                size: 30.0,
//              ),
//            )
//          ],
//          expandedHeight: 150.0,
//          floating: false,
//          pinned: true,
//          centerTitle: false,
//          bottom: PreferredSize(child: Container(), preferredSize: Size(100.0, 45.0)),
//          flexibleSpace: FlexibleSpaceBar(
//            collapseMode: CollapseMode.parallax,
//            centerTitle: false,
//            background: Image.asset(
//              "assets/fashion-category.jpg",
//              fit: BoxFit.cover,
//            ),
//            titlePadding: EdgeInsets.all(0.0),
//            title: Container(
//              padding: EdgeInsets.all(10.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                mainAxisAlignment: MainAxisAlignment.start,
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Text(
//                    "Categorias",
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontWeight: FontWeight.bold,
//                      fontSize: 12.0,
//                    ),
//                  ),
//                  Text(
//                    "Moda & Acessórios",
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontWeight: FontWeight.bold,
//                      fontSize: 18.0,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//                (context, index) => Container(
//                padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
//                color: Color(0xFFF6F6F6),
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Icon(
//                            Icons.brightness_1,
//                            size: 10.0,
//                            color: Color(0xFFBBBBBB),
//                          ),
//                          Container(width: 5.0),
//                          Icon(
//                            Icons.brightness_1,
//                            size: 10.0,
//                            color: Color(0xFF00BFB2),
//                          ),
//                          Container(width: 5.0),
//                          Icon(
//                            Icons.brightness_1,
//                            size: 10.0,
//                            color: Color(0xFFBBBBBB),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      width: double.infinity,
//                      height: 25.0,
//                      margin: EdgeInsets.only(bottom: 10.0),
//                      child: Text(
//                        "Subcategorias",
//                        style: TextStyle(
//                            color: Color(0xFF555555),
//                            fontWeight: FontWeight.bold,
//                            fontSize: 18.0),
//                      ),
//                    ),
//                    Container(
//                      height: 115.0,
//                      child: ListView(
//                        scrollDirection: Axis.horizontal,
//                        children: <Widget>[
//                          Container(
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(22.0),
//                              image: DecorationImage(
//                                image:
//                                AssetImage("assets/comida-brasileira.jpg"),
//                              ),
//                            ),
//                            margin: EdgeInsets.only(right: 10.0),
//                            padding: EdgeInsets.all(10.0),
//                            width: 115.0,
//                            child: Center(
//                              child: Text(
//                                "Moda Masculina",
//                                style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                                textAlign: TextAlign.center,
//                              ),
//                            ),
//                          ),
//                          Container(
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(22.0),
//                              image: DecorationImage(
//                                image: AssetImage("assets/churrasco.jpg"),
//                              ),
//                            ),
//                            margin: EdgeInsets.only(right: 10.0),
//                            padding: EdgeInsets.all(10.0),
//                            width: 115.0,
//                            child: Center(
//                              child: Text(
//                                "Moda Feminina",
//                                style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                                textAlign: TextAlign.center,
//                              ),
//                            ),
//                          ),
//                          Container(
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(22.0),
//                              image: DecorationImage(
//                                image: AssetImage("assets/comida-japonesa.jpg"),
//                              ),
//                            ),
//                            margin: EdgeInsets.only(right: 10.0),
//                            padding: EdgeInsets.all(10.0),
//                            width: 115.0,
//                            child: Center(
//                              child: Text(
//                                "Calçados",
//                                style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                                textAlign: TextAlign.center,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                )),
//            childCount: 1,
//          ),
//        ),
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//                (context, index) => Container(
//              padding: EdgeInsets.all(10.0),
//              color: Color(0xFFF6F6F6),
//              child: Column(
//                children: <Widget>[
//                  Divider(),
//                  Container(
//                    width: double.infinity,
//                    height: 25.0,
//                    margin: EdgeInsets.only(top: 10.0),
//                    child: Row(
//                      children: <Widget>[
//                        Expanded(
//                          child: FlatButton(
//                            padding: EdgeInsets.all(0.0),
//                            child: Container(
//                              alignment: Alignment.centerLeft,
//                              child: Text(
//                                "Próximos",
//                                style: TextStyle(
//                                  color: Color(0xFF555555),
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 18.0,
//                                ),
//                              ),
//                            ),
//                            onPressed: () {
//                              print("Próximos");
//                            },
//                          ),
//                        ),
//                        Expanded(
//                          child: FlatButton(
//                            padding: EdgeInsets.all(0.0),
//                            child: Container(
//                              alignment: Alignment.centerRight,
//                              child: Text(
//                                "Distância",
//                                style: TextStyle(
//                                  color: Color(0xFF777777),
//                                  fontSize: 14.0,
//                                ),
//                              ),
//                            ),
//                            onPressed: () {
//                              storesList
//                                  .sort((a, b) => a.score.compareTo(b.score));
//                              print("Populares");
//                              return buildList(storesList);
//                            },
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            childCount: 1,
//          ),
//        ),
//        SliverFixedExtentList(
//          itemExtent: 110.0,
//          delegate: SliverChildBuilderDelegate(
//                  (context, index) => Container(
//                height: 110.0,
//                child: RaisedButton(
//                  color: Color(0xFFF6F6F6),
//                  padding: EdgeInsets.all(0.0),
//                  elevation: 2.0,
//                  onPressed: () {
//                    getStoreName(storesList[index].name);
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) =>
//                            Products(store: storesList[index].name),
//                      ),
//                    );
//                  },
//                  child: StoreListItem(
//                    photo: Container(
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(18.0),
//                        image: DecorationImage(
//                          image: NetworkImage(storesList[index].photo),
//                          fit: BoxFit.fill,
//                        ),
//                      ),
//                    ),
//                    name: storesList[index].name,
//                    score: storesList[index].score,
//                    delivery: storesList[index].delivery,
//                    meters: storesList[index].meters.floor().toString(),
//                    description: storesList[index].description,
//                  ),
//                ),
//              ),
//              childCount: storesList.length),
//        ),
//      ],
//    );
//  }
//}
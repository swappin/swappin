import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/ui/products.dart';
import 'package:swappin/src/ui/widgets/no-stores.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/widgets/no-stores.dart';
import 'package:swappin/src/ui/widgets/store-list-item.dart';
import '../blocs/stores_bloc_provider.dart';
import '../models/store.dart';

class StoreListscreen extends StatefulWidget {
  final String category;
  final String cover;
  final List subcategories;

  const StoreListscreen(
      {Key key, @required this.category, this.cover, this.subcategories})
      : super(key: key);

  @override
  _StoreListState createState() {
    return _StoreListState(
      category: this.category,
      cover: this.cover,
      subcategories: this.subcategories,
    );
  }
}

String store;

class _StoreListState extends State<StoreListscreen> {
  StoresBloc _bloc;
  String category;
  String subcategory;
  bool isSubcategory = false;
  String cover;
  List subcategories;
  List<Color> colorList = [];

  _StoreListState({this.category, this.cover, this.subcategories});

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = StoresBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.topCenter,
      child: StreamBuilder(
        stream: _bloc.storesList(isSubcategory, category, subcategory),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docs = snapshot.data.documents;
            List<Store> storesList = _bloc.mapToList(docList: docs);
            if (storesList.isNotEmpty) {
              storesList
                  .sort((a, b) => a.meters.compareTo(b.meters));
              return buildList(storesList);
            } else {
              if (!storesList.contains(subcategory)) {
                print("Ahuuuul");
                return buildList(storesList);
              }
              return NoStoresScreen();
            }
          } else {
            return LoaderScreen();
          }
        },
      ),
    );
  }

  Widget buildList(List<Store> storesList) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 150,
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: AssetImage(cover),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Categorias",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF82FAE4),
                    ),
                  ),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            height: 100,
            child: subcategoryListBuilder(),
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
                        fontSize: 14.0,
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
                        fontSize: 12.0,
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
          storeListBuilder(storesList),
        ],
      ),
    );
  }

  int _selectedIndex;

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget storeListBuilder(List<Store> storesList) {
    if(userRange == null){
      userRange = 2500;
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: storesList.length,
      itemBuilder: (BuildContext context, int index) {
        print(storesList[index].meters);
        if (userRange > storesList[index].meters.floor()) {
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
                        builder: (context) => Products(
                          store: storesList[index].name,
                          adress: storesList[index].adress,
                          photo: storesList[index].photo,
                          delivery: storesList[index].delivery,
                          score: storesList[index].score,
                          distance: storesList[index].meters,
                        ),
                      ),
                    );
                  },
                  child: StoreListItem(
                    photo: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.0),
                        image: DecorationImage(
                          image: NetworkImage(storesList[index].photo),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    name: storesList[index].name,
                    score: storesList[index].score,
                    adress: storesList[index].adress,
                    meters: storesList[index].meters.floor().toString(),
                    subcategories: storesList[index].subcategories,
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
      },
    );
  }

  Widget subcategoryListBuilder() {
    subcategories.asMap().forEach((index, data) {
      colorList.add(Color(0xFFBBBBBB));
    });
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: subcategories.length,
      itemBuilder: (BuildContext context, int index) {
        return FlatButton(
          padding: EdgeInsets.only(right: 8),
          onPressed: () {
            print(isSubcategory);
            if (!isSubcategory) {
              subcategory = subcategories[index];
            } else {
              subcategory = "";
            }
            setState(() {
              _onSelected(index);
              isSubcategory = !isSubcategory;
            });
          },
          child: Container(
            height: 42,
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _selectedIndex != null &&
                      _selectedIndex == index &&
                      isSubcategory != false
                  ? Color(0xFF00BFB2)
                  : Color(0xFFBBBBBB),
            ),
            child: Center(
              child: Text(
                subcategories[index],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}

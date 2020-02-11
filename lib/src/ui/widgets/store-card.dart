import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/stores_bloc.dart';
import 'package:swappin/src/blocs/stores_bloc_provider.dart';
import 'package:swappin/src/models/review.dart';
import 'package:swappin/src/models/store.dart';
import 'package:swappin/src/ui/widgets/score-stars.dart';

class StoreCard extends StatefulWidget {
  final String storeName;
  final String storeAdress;
  final String storePhoto;

  StoreCard({
  Key key,
  @required this.storeName,
    this.storeAdress,
    this.storePhoto,
  }) : super(key: key);
  @override
  _StoreCardState createState() => _StoreCardState(
    storeName: this.storeName,
    storeAdress: this.storeAdress,
    storePhoto: this.storePhoto
  );
}

class _StoreCardState extends State<StoreCard> {
  StoresBloc _bloc;

  String storeName;
  String storeAdress;
  String storePhoto;

  _StoreCardState({this.storeName, this.storeAdress, this.storePhoto});


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
    return
      Container(
        alignment: Alignment.center,
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
                        borderRadius:
                        BorderRadius.circular(100.0),
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
                        borderRadius:
                        BorderRadius.circular(100.0),
                        border: Border.all(
                            color: Colors.white, width: 4.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              storePhoto,
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

                    StreamBuilder(
                      stream: _bloc.getStoreReview(storeName),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        List<num> finalReviewList = [];
                        double finalReview;
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> docList = snapshot.data.documents;
                          if (docList != null) {
                            docList.asMap().forEach((index, document) {
                              num userReview = document.data["userReview"];
                              if (userReview != null) {
                                finalReviewList.add(userReview);
                                num reviewSum = finalReviewList.reduce((curr, next) => curr + next);
                                finalReview = reviewSum / docList.length;
                                print("oH MY FINAL REVIEW $finalReview");
                              }
                            });
                          }
                          return ScoreStars(score: finalReview != null ? finalReview : 0);
                        } else {
                          return Text("HUSDHUASHSAUAS");
                        }
                      },
                    ),
                    Container(
                      child: Text(
                        storeName,
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
                        mainAxisAlignment:
                        MainAxisAlignment.start,
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
                              storeAdress,
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
      );
  }
}

import 'package:flutter/material.dart';

class SearchListItem extends StatelessWidget {
  final String productName;
  final Widget productPhoto;
  final double productPrice;
  final String storeName;
  final String storeAdress;
  final String distance;

  SearchListItem(
      {Key key,
      this.productName,
      this.productPhoto,
      this.productPrice,
      this.storeName,
      this.storeAdress,
      this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: productPhoto,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 2.0, 0.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              productName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Text(
                            'R\$${productPrice.toStringAsFixed(2)}',
                            overflow: TextOverflow.ellipsis,
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
                    Container(
                      child: Row(
                        children: <Widget>[
                          Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              "assets/icons/black/home.png",
                              width: 14.0,
                            ),
                          ),
                          Container(
                            width: 4.0,
                          ),
                          Container(
                            child: RichText(
                              softWrap: true,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Quicksand',
                                  color: Color(0xFF666666),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "${distance}m",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: " em ",
                                    style: TextStyle(
                                      color: Color(0xFF333333)
                                    )
                                  ),
                                  TextSpan(
                                      text: "$storeName.",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

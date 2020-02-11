import 'package:flutter/material.dart';

class StoreListItem extends StatelessWidget {
  final String name;
  final String adress;
  final String meters;
  final String description;
  final Widget photo;
  final double score;
  final List subcategories;

  StoreListItem({
    Key key,
    this.name,
    this.adress,
    this.meters,
    this.description,
    this.photo,
    this.score,
    this.subcategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: photo,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0.0, 2.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '$name',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Opacity(
                                    opacity: 1.0,
                                    child: Image.asset(
                                      "assets/icons/gradient/pin.png",
                                      width: 11,
                                    ),
                                  ),
                                  Container(
                                    width: 5,
                                  ),
                                  Text(
                                    '${meters}m',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF666666)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.3,
                                      child: Image.asset(
                                        "assets/icons/black/home.png",
                                        width: 10.0,
                                      ),
                                    ),
                                    Container(
                                      width: 4.0,
                                    ),
                                    Container(
                                      child: Text(
                                        '$adress',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                          fontFamily: 'Quicksand',
                                          color: Color(0xBB000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 3.0)),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${subcategories.join(', ')}',
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Quicksand',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

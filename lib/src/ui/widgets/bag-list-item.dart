import 'package:flutter/material.dart';

class BagListItem extends StatelessWidget {
  final String productName;
  final String storeName;
  final String code;
  final String note;
  final Widget photo;
  final num price;

  BagListItem({
    Key key,this.productName,
    this.code,
    this.photo,
    this.storeName,
    this.note,
    this.price,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: photo,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$productName',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Loja: $storeName',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      'R\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  FlatButton(onPressed: (){

                  }, child: Text("0")),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

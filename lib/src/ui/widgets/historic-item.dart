import 'package:flutter/material.dart';
import 'package:swappin/src/ui/notifications.dart';
import 'package:swappin/src/ui/status.dart';
import 'package:swappin/src/ui/widgets/score-stars.dart';

class HistoricListItem extends StatelessWidget {
  final String storeName;
  final String storeAdress;
  final String storePhoto;
  final String code;
  final String note;
  final String method;
  final DateTime initialDate;
  final String finalDate;
  final String status;
  final List<dynamic> productList;
  final List<dynamic> priceList;
  final List<dynamic> amountList;
  final num total;

  HistoricListItem({
    Key key,
    this.storeName,
    this.storeAdress,
    this.storePhoto,
    this.code,
    this.note,
    this.method,
    this.initialDate,
    this.finalDate,
    this.status,
    this.productList,
    this.priceList,
    this.amountList,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0x22777777),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(6, 6, 15, 6),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 68,
                  height: 68,
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {},
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
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
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 4),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              storeName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xFF666666),
                              ),
                            ),
                          ),
                          Text(
                            code,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(0xFFBBBBBB),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        storeAdress,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: Color(0xFF666666),
                        ),
                      ),
                      Text(
                        finalDate,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(6),
            width: double.infinity,
            height: 65,
            child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "${amountList[index].toString()}   ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF666666),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            productList[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Color(0xFF666666),
                            ),
                          ),
                        ),
                        Text(
                          "R\$${priceList[index].toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                Text(
                  "R\$${priceList.reduce((curr, next) => curr + next).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Método de Pagamento:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                Text(
                  "$method",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Avaliação:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                ScoreStars(score: 5)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Ajuda",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color(0xFF00BFB2),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

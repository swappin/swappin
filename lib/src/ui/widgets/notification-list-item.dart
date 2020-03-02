import 'package:flutter/material.dart';
import 'package:swappin/src/ui/notifications.dart';
import 'package:swappin/src/ui/status.dart';

class NotificationListItem extends StatelessWidget {
  final String code;
  final String storeName;
  final String storePhoto;
  final String status;
  final String finalDate;

  final List<dynamic> productsList;
  final List<dynamic> amountList;
  final double total;

  NotificationListItem({
    Key key,
    this.code,
    this.storeName,
    this.productsList,
    this.amountList,
    this.storePhoto,
    this.status,
    this.finalDate,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (int.parse(status)) {
      case 1:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 78,
                    height: 78,
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
                                  Color(0xFFCCCCCC),
                                  Color(0xFFBBBBBB),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border:
                                  Border.all(color: Colors.white, width: 4.0),
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
                  Container(
                    child: productsList.length <= 1
                        ? Expanded(
                            child: RichText(
                              softWrap: true,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Oi, neném! 🤩 Seu pedido "),
                                  TextSpan(
                                      text:
                                          "${amountList[0]}x ${productsList[0]}",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          " foi realizado e está aguardando confirmação de "),
                                  TextSpan(
                                      text: "$storeName.",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: RichText(
                              softWrap: true,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Oi, neném! 🤩"),
                                  TextSpan(
                                      text:
                                          " Seus pedidos foram enviados e estão aguardando confirmação de "),
                                  TextSpan(
                                      text: "$storeName.",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(
                                "assets/icons/black/clock.png",
                                width: 14.0,
                              ),
                            ),
                          ),
                          Text(
                            finalDate,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        break;
      case 2:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 78,
                    height: 78,
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
                                  Color(0xFFCCCCCC),
                                  Color(0xFFBBBBBB),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border:
                                  Border.all(color: Colors.white, width: 4.0),
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
                  Container(
                    child: Expanded(
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    "Pedido aceito! Aguarde que tudo está sendo preparado por "),
                            TextSpan(
                                text: "$storeName. 🤙",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(
                                "assets/icons/black/clock.png",
                                width: 14.0,
                              ),
                            ),
                          ),
                          Text(
                            finalDate,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        break;
      case 3:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 78,
                    height: 78,
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
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border:
                                  Border.all(color: Colors.white, width: 4.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  storePhoto,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Hey coisa linda, prontinho! 😍",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " Tudo foi preparado por "),
                            TextSpan(
                                text: "$storeName.",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    " Não esqueça de avaliar sua experiência."),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(
                                "assets/icons/black/clock.png",
                                width: 14.0,
                              ),
                            ),
                          ),
                          Text(
                            finalDate,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      case 4:
        print(storePhoto);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 78,
                    height: 78,
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
                                  Color(0xFFDE4B4B),
                                  Color(0xFFB52B2B),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border:
                                  Border.all(color: Colors.white, width: 4.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  storePhoto,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Sentimos muito! 😭",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " Mas infelizmente"),
                            TextSpan(
                                text: " $storeName",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    " não confirmou o seu pedido em tempo. Escolha outra loja ou tente novamente."),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(
                                "assets/icons/black/clock.png",
                                width: 14.0,
                              ),
                            ),
                          ),
                          Text(
                            finalDate,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        break;
    }
  }
}

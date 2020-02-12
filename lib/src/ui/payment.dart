import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swappin/src/ui/bag.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';

class PaymentScreen extends StatefulWidget {
  final double total;

  PaymentScreen({
    Key key,
    @required this.total,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState(total: total);
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController _controller = new TextEditingController();
  double total;
  List<String> paymentMethodList = [
    'Cartão de Crédito - Visa',
    'Cartão de Crédito - Mastercard',
    'Cartão de Crédito - Elo',
    'Cartão de Débito - Visa',
    'Cartão de Débito - Mastercard',
    'Cartão de Débito - Elo',
    'Dinheiro',
  ];
  List<String> paymentThumbnailList = [
    'assets/payments/mastercard.png',
    'assets/payments/visa.png',
    'assets/payments/elo.png',
    'assets/payments/mastercard.png',
    'assets/payments/visa.png',
    'assets/payments/elo.png',
    'assets/payments/money.png',
  ];

  _PaymentScreenState({this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F4F5),
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Image.asset(
            "assets/icons/black/arrow_left_1.png",
            width: 10.0,
          ),
        ),
        title: Text(
          "Método de Pagamento",
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
      body: ListView.builder(
          itemCount: paymentMethodList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text(paymentMethodList[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Color(0xFF666666),
                  ),
                ),
                trailing: Image.asset(
                  paymentThumbnailList[index],
                  width: 40.0,
                ),
                onTap: () {
                  if (paymentMethodList[index] != "Dinheiro") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BagScreen(
                          paymentMethod: paymentMethodList[index],
                          paymentThumbnail: paymentThumbnailList[index],
                        ),
                      ),
                    );
                  } else {
                    paymentChangeCalculator(paymentMethodList[index], paymentThumbnailList[index]);
                  }
                },
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE3E4E5),
                  ),
                ),
              ),
            );
          }),
    );
  }

  paymentChangeCalculator(String paymentMethod, String paymentThumbnail) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: (56 * 6).toDouble(),
          child: Container(
            padding: EdgeInsets.all(30.0),
            color: Colors.white,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    child: Text(
                      "Você vai precisar de troco?",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                  Container(
                    height: 80.0,
                    child: TextField(
                      style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                      color: Color(0xFF00BFB2),
                    ),
                      decoration: InputDecoration(
                        labelText: "Digite o valor",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                          color: Color(0xFF00BFB2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF63ebe1), width: 1.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF00BFB2), width: 1.0),
                        ),
                        focusColor: Color(0xFF00BFB2),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SwappinButton(
                    onPressed: () {
                      print(paymentMethod);
                      print(paymentThumbnail);
                      print(_controller.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BagScreen(
                            paymentMethod: paymentMethod,
                            paymentThumbnail: paymentThumbnail,
                            paymentChange: _controller.text,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      child: Text(
                        "Confirmar",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25.0),
                    height: 20.0,
                    child: Center(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Não preciso de troco",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF00BFB2),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
//
//  Future<void> _needChange(BuildContext context, double total) {
//    print("EIS QUE MEU TOTAL NO PAYMENT: $total");
//    return showDialog<void>(
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text('Vai precisar de troco?'),
//              Text(
//                'Se sim, digite o valor abaixo:',
//                style: TextStyle(
//                  color: Colors.grey,
//                  fontSize: 16.0,
//                ),
//              )
//            ],
//          ),
//          content: TextField(
//            controller: _controller,
//            keyboardType: TextInputType.number,
//            decoration: InputDecoration(
//              fillColor: Colors.white,
//              border: OutlineInputBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                  borderSide: BorderSide(color: Color(0xFFE1E3E5))),
//              filled: true,
//              contentPadding:
//                  EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
//              labelText: "Digite o valor",
//            ),
//          ),
//          actions: <Widget>[
//            Row(
//              children: <Widget>[
//                FlatButton(
//                  child: Text(
//                    'Não',
//                    style: TextStyle(
//                      color: Colors.redAccent,
//                    ),
//                  ),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                ),
//                FlatButton(
//                  child: Text('Confirmar'),
//                  onPressed: () {
//                    print("MEU TOTAL AQUI NO CONFIRMAR DA PORRA TODA: $total");
//                    print("e meu troco nesse negºocio maluuuco: ${_controller.text}");
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => UserBag(
//                          paymentMethod: "Dinheiro",
//                          paymentThumbnail:
//                          "http://www.pngmart.com/files/7/Bill-PNG-HD.png",
//                          paymentChange: int.parse(_controller.text).toDouble() - total,
//                        ),
//                      ),
//                    );
//                  },
//                ),
//              ],
//            ),
//          ],
//        );
//      },
//    );
//  }
}

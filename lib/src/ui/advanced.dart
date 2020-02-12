import 'package:flutter/material.dart';
import 'package:swappin/src/ui/delete.dart';

class AdvancedSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              "assets/icons/black/arrow_left_1.png",
              width: 10.0,
            ),
          ),
        ),
        title: Text(
          "Configurações Avançadas",
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
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/delete.png",
                  width: 20,
                ),
              ),
              title: Text(
                "Deletar Conta",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
              trailing: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  "assets/icons/black/arrow_right.png",
                  width: 8,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteAccount(),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE3E4E5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

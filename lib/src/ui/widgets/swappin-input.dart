import 'package:flutter/material.dart';

class SwappinInput extends StatelessWidget {
  Stream<String> stream;
  Function onChanged;
  String hintText;
  String icon;
  TextInputType keyboardType;
  bool obscureText;

  SwappinInput({this.stream, this.icon, this.hintText, this.onChanged, this.keyboardType, this.obscureText});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Container(
          height: 60.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFDDDDDD),
              width: 1.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(25, 14, 25, 10),
                child: TextFormField(
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  obscureText: obscureText,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                    errorText: snapshot.error,
                    errorStyle: TextStyle(
                      color: Color(0xFF00BFB2),
                      fontFamily: 'Poppins',
                      fontSize: 10,
                    ),
                    errorBorder:  OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Container(
                width: 18,
                margin: EdgeInsets.only(right: 28),
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset("assets/icons/black/$icon.png"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/models/user.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/widgets/empty.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  LoginBloc _bloc;
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
          "Deletar Conta",
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: StreamBuilder(
          stream: _bloc.getCurrentUser(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data.documents;
              List<User> userData = _bloc.mapToList(docList: docs);
              if (userData.isNotEmpty) {
                print(userData[0].name);
                return buildDeleteForm(userData);
              } else {
                return EmptyScreen(
                  message: "Sentimos muito, mas algo de errado aconteceu!",
                  image: "internet",
                );
              }
            } else {
              return LoaderScreen();
            }
          },
        ),
      ),
    );
  }

  Widget buildDeleteForm(List<User> userData) {
    return Column(
      children: <Widget>[
        Container(
          child:
          Text(
            "Sentimos muito por não atender suas expectativas, $currentUserName.  =(",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),

        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        Container(
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
                padding: EdgeInsets.only(left: 25.0),
                child: TextFormField(
                  controller: _reasonController,
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
                    hintText: "Qual o motivo da sua saída da Swappin?",
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
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Container(
                width: 18,
                margin: EdgeInsets.only(right: 28),
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset("assets/icons/black/password.png"),
                ),
              ),
            ],
          ),
        ),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        Container(
          height: 200.0,
          padding: EdgeInsets.only(bottom: 50.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFDDDDDD),
              width: 1.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: TextField(
            controller: _messageController,
            maxLengthEnforced: false,
            maxLines: 10,
            decoration: InputDecoration(
              filled: false,
              hintText:
                  "Se possível, nos diga porque está nos deixando para que possamos refletir e melhorar...",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.transparent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.transparent),
              ),
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 10,
              ),
            ),
          ),
        ),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        Container(
          alignment: Alignment(0.0, 0.0),
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: SwappinButton(
            onPressed: () {
              _bloc.registerDeletedUser(
                  userData[0].birth,
                  userData[0].genre,
                  userData[0].photo,
                  _reasonController.text,
                  _messageController.text,
                  userData[0].registerDate);
            },
            child: Text(
              "Confirmar Exclusão",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

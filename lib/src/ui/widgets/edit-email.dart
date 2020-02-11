import 'package:flutter/material.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/profile.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/swappin-input.dart';

class EditEmail extends StatefulWidget {
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  LoginBloc _bloc;

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
          "Editar E-mail",
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
        alignment: Alignment(0.0, 0.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
        child: Column(
          children: <Widget>[
            Container(
              child:
              SwappinInput(
                stream: _bloc.email,
                onChanged: _bloc.changeEmail,
                hintText: currentUserEmail,
                icon: "email",
                obscureText: false,
              ),
            ),
            Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
            submitButton(),
          ],
        ),
      ),
    );
  }


  Widget submitButton() {
    return StreamBuilder(
        stream: _bloc.signUpStatus,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return button();
          } else {
            return LoaderScreen();
          }
        });
  }

  Widget button() {
    return Container(
      height: 60,
      width: double.infinity,
      child: SwappinButton(
        onPressed: () {
          _confirmEdit(context);
        },
        child: Text(
          "Alterar E-mail",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
        ),
      ),
    );
  }


  Future<void> _confirmEdit(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alterar E-mail?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Color(
                0xFF00BFB2,
              ),
            ),
          ),
          content: Column(
            children: <Widget>[
              const Text(
                'Tem certeza que deseja realizar a mudança de e-mail?',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(
                    0xFF666666,
                  ),
                ),
              ),

              SwappinInput(
                stream: _bloc.password,
                onChanged: _bloc.changePassword,
                hintText: "Digite seu password",
                icon: "email",
                obscureText: false,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    'Sim',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Color(
                        0xFF00BFB2,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _bloc.updateUserEmail().then(
                          (onUpdate) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}

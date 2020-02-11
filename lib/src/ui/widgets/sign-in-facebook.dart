import 'package:swappin/src/ui/register.dart';

import '../../utils/strings.dart';
import 'package:flutter/material.dart';
import '../../blocs/login_bloc_provider.dart';
import '../home.dart';

class SignInFacebook extends StatefulWidget {
  @override
  SignInFacebookState createState() {
    return SignInFacebookState();
  }
}

class SignInFacebookState extends State<SignInFacebook> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        submitButton()
      ],
    );
  }

  Widget submitButton() {
    return StreamBuilder(
      stream: _bloc.signInStatus,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return facebookButton();
      },
    );
  }

  Widget facebookButton() {
    return Container(
      height: 60,
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          authenticateUserWithFacebook();
        },
        child: Text(
          StringConstant.signInWithFacebook,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 4, color: Colors.white),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  void authenticateUserWithFacebook() {
    _bloc.showProgressBar(true);
    _bloc.signInWithFacebook().then((value) {
      print("OH MY VALUE AQUI EMAIL ${value}");
      _bloc.authenticateUser(value[1]).then(
        (onValue) {
          if (onValue == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterScreen(
                          uid: value[0],
                          email: value[1],
                          displayName: value[2],
                          photoUrl: value[3],
                        )));
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  currentIndex: 0,
                ),
              ),
            );
          }
        },
      );
    });
  }

  void showErrorMessage() {
    final snackbar = SnackBar(
        content: Text(StringConstant.errorMessage),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}

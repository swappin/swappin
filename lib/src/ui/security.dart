import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/login.dart';
import 'package:swappin/src/ui/profile.dart';
import 'package:swappin/src/ui/widgets/reset-confirm.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/swappin-input.dart';

class Security extends StatefulWidget {
  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc _bloc;
  String _errorMessage;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
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
          "Senha & Segurança",
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
      body: SafeArea(child: Container(
        alignment: Alignment(0.0, 0.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SwappinInput(
                stream: _bloc.password,
                onChanged: _bloc.changePassword,
                hintText: "Senha atual",
                icon: "email",
                obscureText: true,
              ),
            ),
            Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
            Container(
              child: SwappinInput(
                stream: _bloc.newPassword,
                onChanged: _bloc.changeNewPassword,
                hintText: "Nova senha",
                icon: "password",
                obscureText: true,
              ),
            ),
            Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
            Container(
              child: SwappinInput(
                stream: _bloc.confirmPassword,
                onChanged: _bloc.changeConfirmPassword,
                hintText: "Confirme a nova senha",
                icon: "password",
                obscureText: true,
              ),
            ),
            Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
            submitButton(),

            Container(
              height: 50,
              child: FlatButton(
                onPressed: () {
                  _bloc.resetPasswordLogged().then(
                        (onValue) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetConfirm(),
                      ),
                    ),
                  ).catchError((onError){
                    _errorMessage = onError.toString();
                    showErrorMessage();
                  });

                },
                child: Text("Esqueceu sua senha?",
                  style: TextStyle(
                    color: Color(0xFF05A9C7),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),),
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
          if (_bloc.validateNewPasswordFields()) {
            _confirmEditPass(context);
          } else {
            showErrorMessage();
          }
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

  Future<void> _confirmEditPass(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alterar Senha?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Color(
                0xFF00BFB2,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Para concluir essa ação, é preciso realizar o login novamente com a nova senha.',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color(
                0xFF666666,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          actions: <Widget>[
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
                'Confirmar',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(
                    0xFF00BFB2,
                  ),
                ),
              ),
              onPressed: () {
                _bloc.updateUserPassword().then((value) async {
                  if (value == 0) {
                    _bloc.showProgressReg(false);
                    _errorMessage =
                        "Ops... Parece que o email ${_bloc.emailAddress} já está em uso.";
                    Navigator.pop(context);
                    showErrorMessage();
                  } else {
                    await _auth.signOut().then((onSignOut) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    });
                  }
                }).catchError((onError) {
                  Navigator.pop(context);
                  if (onError.toString() ==
                      "PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)") {
                    _errorMessage =
                        "A senha atual está incorreta. Verifique e tente novamente.";

                    showErrorMessage();
                  } else if (onError.toString() ==
                      "PlatformException(ERROR_TOO_MANY_REQUESTS, Too many unsuccessful login attempts. Please try again later., null)") {
                    _errorMessage =
                        "Você tentou uma senha incorreta muitas vezes. Tente novamente mais tarde.";

                    showErrorMessage();
                  }
                  print(onError.toString());
                });
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorMessage() {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: EdgeInsets.all(20),
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            gradient: LinearGradient(colors: [
              Color(0xFF05A9C7),
              Color(0xFF00BFB2),
            ], stops: [
              0.0,
              0.5,
            ])),
        child: Text(
          _errorMessage != null
              ? _errorMessage
              : "Ooops... Algo de errado aconteceu!\nPor favor, verifique os dados inseridos novamente.",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}

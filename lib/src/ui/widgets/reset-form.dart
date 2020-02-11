import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/login_bloc.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/ui/login.dart';
import 'package:swappin/src/ui/widgets/reset-confirm.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/swappin-input.dart';
import 'package:swappin/src/utils/strings.dart';

class ResetForm extends StatefulWidget {
  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  TextEditingController _resetController = TextEditingController();
  LoginBloc _bloc;
  bool emailIsSent = true;

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
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/logo.png",
              width: 58,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Para recuperar sua senha",
                  style: TextStyle(
                    color: Color(0xFF00BFB2),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Digite seus dados de acesso",
                  style: TextStyle(
                    color: Color(0xFF00BFB2),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                Container(margin: EdgeInsets.only(bottom: 15)),
                SwappinInput(
                  stream: _bloc.resetEmail,
                  onChanged: _bloc.changeResetEmail,
                  hintText: StringConstant.emailHint,
                  icon: "email",
                  obscureText: false,
                ),
                Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: SwappinButton(
                    onPressed: () {
                      if (_bloc.validateResetField()) {
                        _bloc.resetPassword().then(
                              (onValue) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ResetConfirm(),
                            ),
                          ),
                        );
                      } else {
                        showErrorMessage();
                      }
                    },
                    child: Text(
                      StringConstant.submit,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 50),
                ),
              ],
            ),
          ),
        ],
      ),
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
          "Ooops... Algo de errado aconteceu!\nPor favor, verifique os dados inseridos novamente.",
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
    Scaffold.of(context).showSnackBar(snackbar);
  }
}

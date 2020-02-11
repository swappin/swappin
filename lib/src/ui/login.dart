import 'package:swappin/src/app.dart';
import 'package:swappin/src/initial.dart';
import 'package:swappin/src/ui/register.dart';
import 'package:swappin/src/ui/reset.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/widgets/swappin-icon.dart';
import 'package:swappin/src/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/swappin-input.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController _controller = TextEditingController();
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
    return StreamBuilder(
      stream: _bloc.signInStatus,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return loginScreenContent();
        } else {
          return LoaderScreen();
        }
      },
    );
  }

  Widget loginScreenContent(){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Initial(),
            ),
          ),
          child: SwappinIcon(
            icon: "arrow_left_1",
            firstColor: Color(0xFF00BFB2),
            secondColor: Color(0xFF05A9C7),
            width: 18,
            height: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: LoginBlocProvider(
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage("assets/background.jpg"),
//              fit: BoxFit.fill,
//            ),
            ),
            child: loginButtons(),
          ),
        ),
      ),
    );
  }
  Widget loginButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
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
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Bem-vindo,",
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
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 15)),
              SwappinInput(
                stream: _bloc.email,
                onChanged: _bloc.changeEmail,
                hintText: StringConstant.emailHint,
                icon: "profile",
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              SwappinInput(
                stream: _bloc.password,
                onChanged: _bloc.changePassword,
                hintText: StringConstant.passwordHint,
                icon: "password",
                obscureText: true,
              ),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              Container(
                height: 60,
                width: double.infinity,
                child: SwappinButton(
                  onPressed: () {
                    if (_bloc.validateFields()) {
                      authenticateUser();
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
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetScreen(),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                  child: Text(
                    "Esqueceu sua senha?",
                    style: TextStyle(
                      color: Color(0xFF00BFB2),
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        socialLogin(),
      ],
    );
  }

  Widget socialLogin() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Text(
              "Ou acesse com:",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                color: Colors.grey,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                margin: EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () => authenticateUserWithGoogle(),
                  child: Image.asset("assets/google.png"),
                ),
              ),
              Container(
                width: 35,
                height: 35,
                margin: EdgeInsets.only(left: 5),
                child: GestureDetector(
                  onTap: () => authenticateUserWithFacebook(),
                  child: Image.asset("assets/facebook.png"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void authenticateUser() {
    checkLoginMethod(_bloc.emailAddress);
    _bloc.signInWithEmailAndPassword().then((value) {
      if (value == 0) {
        _bloc.showProgressBar(false);
        showErrorMessage();
      } else {
        _bloc.showProgressBar(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => App()));
      }
    });
  }

  void authenticateUserWithGoogle() {
    _bloc.showProgressBar(true);
    _bloc.signInWithGoogle().then(
          (value) {
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
                  builder: (context) => App(),
                ),
              );
            }
          },
        );
      },
    );
  }

  void authenticateUserWithFacebook() {
    _bloc.showProgressBar(true);
    _bloc.signInWithFacebook().then(
          (value) {
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
                  builder: (context) => App(),
                ),
              );
            }
          },
        );
      },
    );
  }

  void checkLoginMethod(String email) {
    if (RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
    } else if (RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
        .hasMatch(email)) {
    } else {
      print("Error.");
    }
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

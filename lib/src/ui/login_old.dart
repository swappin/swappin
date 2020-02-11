import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:swappin/src/ui/home.dart';
import 'package:swappin/src/ui/register.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String _verificationId;
String passwordVerificationCodeHandler = '';
String emailPhoneNumberlHandler = '';

class SignInPage extends StatefulWidget {
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25.0),
        child: Builder(builder: (BuildContext context) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                      child: Image.asset(
                        'assets/icon.jpg',
                        width: 150.0,
                        height: 150.0,
                      ),
                    ),
                    Container(
                      height: 150.0,
                      padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Olá',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            'Como deseja começar?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _EmailOrPhoneNumberSignInSection(Scaffold.of(context)),
//            _PhoneSignInSection(Scaffold.of(context)),
//            _EmailLinkSignInSection(),
              Center(
                child: Text(
                  'Ou',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

/* Login w/ E-mail and Password or Phone Number */
class _EmailOrPhoneNumberSignInSection extends StatefulWidget {
  _EmailOrPhoneNumberSignInSection(this._scaffold);

  final ScaffoldState _scaffold;

  @override
  State<StatefulWidget> createState() =>
      _EmailOrPhoneNumberSignInSectionState();
}

class _EmailOrPhoneNumberSignInSectionState
    extends State<_EmailOrPhoneNumberSignInSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailPhoneNumberController =
      TextEditingController();

  String _message = '';

  String loginMethod;

  bool checkLoginMethod(String em) {
    String _isEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    String _isPhoneNumber = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regExpEmail = new RegExp(_isEmail);
    RegExp regExpPhoneNumber = new RegExp(_isPhoneNumber);

    if (regExpEmail.hasMatch(em)) {
      loginMethod = 'E-mail';
      return regExpEmail.hasMatch(em);
    } else if (regExpPhoneNumber.hasMatch(em)) {
      loginMethod = 'PhoneNumber';
      return regExpPhoneNumber.hasMatch(em);
    } else {
      loginMethod = null;
    }
  }

  bool passwordCodeInput = false;
  bool isEmail;
  bool isPhoneNumber;
  String _hintSwitch = 'Insira um e-mail ou telefone';
  Color _backgroundColor = Color(0x99333333);
  Icon _actionIcon = Icon(Icons.account_circle, color: Colors.white);
  String _textActionButton = 'Enviar';
  bool _hiddenText = false;

  void insertEmailPhoneNumber(String description) {
    setState(() {
      _hintSwitch = description;
      _backgroundColor = Color(0x66000000);
      _actionIcon = Icon(Icons.vpn_key, color: Colors.white);
    });
    passwordCodeInput = true;
  }

  void insertPassword() {
    try {
      _auth.createUserWithEmailAndPassword(
          email: emailPhoneNumberlHandler,
          password: passwordVerificationCodeHandler);
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
        );
      });
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {}
      }
    } finally {
      _signInWithEmailAndPassword();
    }
    passwordCodeInput = false;
  }

  void formDataHandle() {
    if (_formKey.currentState.validate()) {
      emailPhoneNumberlHandler = _emailPhoneNumberController.text;
      _emailPhoneNumberController.text = '';
      if (loginMethod == 'E-mail') {
        isEmail = true;
        isPhoneNumber = false;
        _hiddenText = true;
        setState(() {
          _textActionButton = 'Entrar';
        });
        insertEmailPhoneNumber('Insira a Senha');
      } else if (loginMethod == 'PhoneNumber') {
        isPhoneNumber = true;
        isEmail = false;
        setState(() {
          _textActionButton = 'Verificar Código';
        });
        insertEmailPhoneNumber('Insira o Código de Verificação');
        _verifyPhoneNumber();
      }
    } else {
      print("Error - formDataHandle - _formKey.currentState.validate()");
    }
  }

  void formDataSend() {
    passwordVerificationCodeHandler = _emailPhoneNumberController.text;
    if (isEmail == true) {
      insertPassword();
    } else if (isPhoneNumber == true) {
      _signInWithPhoneNumber();
    } else {
      _emailPhoneNumberController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              height: 60.0,
              decoration: BoxDecoration(
                color: _backgroundColor,
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      controller: _emailPhoneNumberController,
                      obscureText: _hiddenText,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelStyle:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                        hintText: _hintSwitch,
                        hintStyle:
                            TextStyle(fontSize: 18.0, color: Colors.white),
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
                        ),
                      ),
                      validator: (String value) {
                        if (value.isEmpty || loginMethod == null) {
                          _emailPhoneNumberController.text = '';
                          return 'Por favor, insira um e-mail ou telefone válido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: 75.0,
                    child: _actionIcon,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  checkLoginMethod(_emailPhoneNumberController.text);
                  if (passwordCodeInput == false) {
                    formDataHandle();
                  } else {
                    formDataSend();
                  }
                },
                child: Text(
                  _textActionButton,
                  style: TextStyle(
                    color: Color(0xFF00BFB2),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2.0, color: Colors.white),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                elevation: 0.0,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _message,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _emailPhoneNumberController.dispose();
    super.dispose();
  }

  // Code to sign in with E-mail and Password.
  void _signInWithEmailAndPassword() async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: emailPhoneNumberlHandler,
      password: passwordVerificationCodeHandler,
    ))
        .user;
    if (user != null) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    } else {}
  }

  // Code to verify Phone Number
  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Credenciais Recebidas: $phoneAuthCredential';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Falha na verificação do Número de Telefone. Código de Erro: ${authException.code}. Mensagem: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      SnackBar(
        content: Text(
            'Por favor, verifique o Código de Verificação enviado para o seu número.'),
      );
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: emailPhoneNumberlHandler,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Code to sign in with Phone Number.
  void _signInWithPhoneNumber() async {
    print("Buceta $passwordVerificationCodeHandler");
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: passwordVerificationCodeHandler,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        });
      } else {
        _message = 'Problemas com o Login.';
      }
    });
  }
}

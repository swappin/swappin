import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/ui/tutorial.dart';
import 'package:swappin/src/ui/policy.dart';
import 'package:swappin/src/ui/register.dart';
import 'package:swappin/src/ui/terms.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/swappin-icon.dart';
import 'package:swappin/src/ui/widgets/swappin-input.dart';
import '../../utils/strings.dart';
import 'package:flutter/material.dart';
import '../../blocs/login_bloc_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  LoginBloc _bloc;
  File _image;
  String _genre = "Gênero";
  String _birth = "Insira sua data de nascimento";
  TextEditingController _confirmPasswordController = TextEditingController();
  String _errorMessage;

  Future getImage(ImageSource _imageSource) async {
    var image = await ImagePicker.pickImage(
        source: _imageSource, imageQuality: 40, maxHeight: 600, maxWidth: 600);

    if (image != null) {
      _bloc.changePhoto;
    }
    setState(() {
      _image = image;
    });
  }

  DateTime selectedDate = DateTime.now();
  final formatedDate = new DateFormat('dd-MM-yyyy');

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        _birth = formatedDate.format(picked);
        selectedDate = picked;
      });
  }

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
          return signUpContent();
        } else {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget signUpContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          photoButton(),
          Container(margin: EdgeInsets.only(top: 5, bottom: 25)),
          SwappinInput(
            stream: _bloc.email,
            onChanged: _bloc.changeEmail,
            hintText: StringConstant.emailHint,
            icon: "email",
            obscureText: false,
          ),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          SwappinInput(
            stream: _bloc.password,
            onChanged: _bloc.changePassword,
            hintText: StringConstant.passwordHint,
            icon: "password",
            obscureText: true,
          ),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          confirmPasswordField(),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          SwappinInput(
            stream: _bloc.name,
            onChanged: _bloc.changeName,
            hintText: StringConstant.nameHint,
            icon: "profile",
            obscureText: false,
          ),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          Stack(
            children: <Widget>[
              Container(
                child: SwappinInput(
                  stream: _bloc.birth,
                  onChanged: _bloc.changeBirth,
                  hintText: _birth,
                  icon: "calendar",
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  onPressed: () => _selectDate(context),
                ),
              ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          genreField(),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          Container(
            child: RichText(
              softWrap: true,
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "Ao clicar em Criar Conta você concorda com nossos "),
                  TextSpan(
                    text: "Termos ",
                    style: TextStyle(
                      color: Color(0xFF02b9bf),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Terms(),
                          ),
                        );
                      },
                  ),
                  TextSpan(
                    text: " e ",
                  ),
                  TextSpan(
                    text: "Política de Privacidade.",
                    style: TextStyle(
                      color: Color(0xFF02b9bf),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Policy(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          submitButton(),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          socialRegister(),
        ],
      ),
    );
  }

  Widget photoButton() {
    return StreamBuilder(
      stream: _bloc.photo,
      builder: (context, snapshot) {
        return Container(
          alignment: Alignment.topCenter,
          child: FlatButton(
            onPressed: showMenuCamera,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 90,
                  height: 90,
                  alignment: Alignment.topLeft,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.1, 0.9],
                            colors: [
                              Color(0xFF00BFB2),
                              Color(0xFF05A9C7),
                            ],
                          ),
                        ),
                      ),
                      _image == null
                          ? SwappinIcon(
                              icon: "camera_1",
                              firstColor: Colors.white,
                              secondColor: Colors.white,
                              width: 25,
                              height: 25,
                            )
                          : Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                image: DecorationImage(
                                    image: _image != null
                                        ? FileImage(
                                            _image,
                                          )
                                        : null,
                                    fit: BoxFit.cover),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  child: _image != null
                      ? RichText(
                          softWrap: true,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "Nossa, nossa, hein...\n"),
                              TextSpan(
                                text: "Sua foto está linda",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF05A9C7),
                                ),
                              ),
                            ],
                          ),
                        )
                      : RichText(
                          softWrap: true,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "Para uma experência melhor\n"),
                              TextSpan(
                                text: "Sorria e poste uma selfie",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF05A9C7),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget confirmPasswordField() {
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
            padding: EdgeInsets.only(left: 25.0),
            child: TextFormField(
              controller: _confirmPasswordController,
              keyboardType: TextInputType.emailAddress,
              onChanged: _bloc.changePassword,
              obscureText: true,
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
                hintText: StringConstant.confirmPasswordHint,
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
    );
  }

  Widget genreField() {
    return Stack(
      children: <Widget>[
        SwappinInput(
          stream: _bloc.genre,
          onChanged: _bloc.changeGenre,
          hintText: _genre,
          icon: "love_2",
          obscureText: false,
        ),
        Container(
          height: 60,
          width: double.infinity,
          child: FlatButton(
            onPressed: () {
              showMenuGenre();
            },
            child: Text(""),
          ),
        ),
      ],
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
          if (_bloc.validateFieldsRegister(
              _birth, _genre, _confirmPasswordController.text)) {
            registerUser();
          } else {
            _errorMessage =
                _bloc.confirmPasswordMessage(_confirmPasswordController.text);
            showErrorMessage();
          }
        },
        child: Text(
          "Criar Conta",
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

  Widget socialRegister() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Text(
              "Ou cadastre-se com:",
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

  registerUser() {
    _bloc.signUpWithEmailAndPassword(_image, _genre).then((value) async {
      if (value == 0) {
        _bloc.showProgressReg(false);
        showErrorMessage();
      } else {
        _bloc.showProgressReg(true);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Tutorial(),
          ),
        );
      }
    });
  }

  showMenuCamera() {
    List<String> iconList = [
      "gallery",
      "camera_2",
    ];
    List<String> choiceList = [
      "Selecionar da Galeria",
      "Tirar Foto com a Câmera",
    ];
    List<ImageSource> imageSourceList = [
      ImageSource.gallery,
      ImageSource.camera,
    ];
    List<Widget> makeRadios() {
      List<Widget> widgetGenreList = new List<Widget>();

      for (int index = 0; index < 2; index++) {
        widgetGenreList.add(
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xAAEEE9FF),
                  width: 1,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () {
                getImage(imageSourceList[index]);
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Opacity(
                      opacity: 0.65,
                      child: Image.asset(
                        "assets/icons/black/${iconList[index]}.png",
                        width: 18,
                      ),
                    ),
                  ),
                  Text(
                    '${choiceList[index]}',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return widgetGenreList;
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: (65 * 4).toDouble(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x44333333),
                  blurRadius: 15.0, // has the effect of softening the shadow
                  spreadRadius: 4.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    10.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Como deseja postar sua foto?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color(0xFF00BFB2),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: makeRadios(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showMenuGenre() {
    List<String> genreList = [
      "Feminino",
      "Masculino",
      "Transexual",
      "Outros",
    ];
    List<Widget> makeRadios() {
      List<Widget> widgetGenreList = new List<Widget>();

      for (int index = 0; index < 4; index++) {
        widgetGenreList.add(
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xAAEEE9FF),
                  width: 1,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _genre = genreList[index];
                  Navigator.pop(context);
                });
              },
              child: Text(
                '${genreList[index]}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ),
        );
      }
      return widgetGenreList;
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: (65 * 6).toDouble(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x44333333),
                  blurRadius: 15.0, // has the effect of softening the shadow
                  spreadRadius: 4.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    10.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 85,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Insira seu gênero:",
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                            fontFamily: 'Quicksand',
                            color: Color(0xBB000000),
                          ),
                        ),
                        Text(
                          "Seja o que quiser, onde estiver.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF00BFB2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: makeRadios(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
    Scaffold.of(context).showSnackBar(snackbar);
  }
}

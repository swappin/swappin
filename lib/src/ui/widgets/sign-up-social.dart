import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:swappin/src/ui/tutorial.dart';
import 'package:swappin/src/ui/policy.dart';
import 'package:swappin/src/ui/terms.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/swappin-icon.dart';
import 'package:swappin/src/ui/widgets/swappin-input.dart';
import '../../utils/strings.dart';
import 'package:flutter/material.dart';
import '../../blocs/login_bloc_provider.dart';

class SignUpSocial extends StatefulWidget {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  SignUpSocial({
    Key key,
    this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
  }) : super(key: key);

  @override
  SignUpSocialState createState() {
    return SignUpSocialState(
        uid: this.uid,
        email: this.email,
        displayName: this.displayName,
        photoUrl: this.photoUrl);
  }
}

class SignUpSocialState extends State<SignUpSocial> {
  LoginBloc _bloc;
  String uid;
  String email;
  String displayName;
  String photoUrl;
  File _image;

  SignUpSocialState({this.uid, this.email, this.displayName, this.photoUrl});

  String _genre = "Gênero";
  String _birth = "Insira sua data de nascimento";

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
          return socialSignUpContent();
        } else {
          return LoaderScreen();
        }
      },
    );
  }

  Widget socialSignUpContent(){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          photoButton(),
          Container(margin: EdgeInsets.only(top: 5, bottom: 25)),
          Stack(
            children: <Widget>[
              SwappinInput(
                stream: _bloc.email,
                onChanged: _bloc.changeEmail,
                hintText: this.email,
                icon: "email",
                obscureText: false,
              ),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.transparent,
              ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
          Stack(
            children: <Widget>[
              SwappinInput(
                stream: _bloc.name,
                onChanged: _bloc.changeName,
                hintText: this.displayName,
                icon: "profile",
                obscureText: false,
              ),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.transparent,
              ),
            ],
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
                  child: Container()
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
                  width: 100,
                  height: 100,
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
                      this.photoUrl == null && _image == null
                          ? SwappinIcon(
                              icon: "camera_1",
                              firstColor: Colors.white,
                              secondColor: Colors.white,
                              width: 25,
                              height: 25,
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border:
                                    Border.all(color: Colors.white, width: 4.0),
                                image: DecorationImage(
                                    image: this.photoUrl == null
                                        ? null
                                        : NetworkImage(
                                            this.photoUrl,
                                          ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  child: RichText(
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
            return CircularProgressIndicator();
          }
        });
  }

  Widget button() {
    return Container(
      height: 60,
      width: double.infinity,
      child: SwappinButton(
        onPressed: () {
          if (_bloc.validateFieldsSocialRegister(
              this.email, this.displayName, _birth, _genre)) {
            registerUser();
          } else {
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

  registerUser() {
    _bloc.registerUser(uid, email, displayName, _birth, _genre, photoUrl, true).then(
      (value) async {
        _bloc.showProgressReg(true);
        await Future.delayed(
          const Duration(seconds: 1),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Tutorial(),
              ),
            );
          },
        );
      },
    ).catchError((onError) {
      _bloc.showProgressReg(false);
      print("Error");
      showErrorMessage();
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

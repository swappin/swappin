import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:swappin/src/app.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/models/user.dart';
import 'package:swappin/src/ui/advanced.dart';
import 'package:swappin/src/ui/animations/loader.dart';
import 'package:swappin/src/ui/profile.dart';
import 'package:swappin/src/ui/widgets/edit-email.dart';
import 'package:swappin/src/ui/widgets/empty.dart';
import 'package:swappin/src/ui/widgets/swappin-button.dart';
import 'package:swappin/src/ui/widgets/swappin-icon.dart';
import 'package:swappin/src/ui/widgets/swappin-input.dart';
import 'package:swappin/src/utils/strings.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
          "Editar Perfil",
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
      body: SafeArea(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
          child: StreamBuilder(
            stream: _bloc.getCurrentUser(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> docs = snapshot.data.documents;
                List<User> userData = _bloc.mapToList(docList: docs);
                if (userData.isNotEmpty) {
                  return editUserProfile(userData);
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
      ),
    );
  }

  Widget editUserProfile(List<User> userData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        photoButton(userData[0].photo),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        SwappinInput(
          stream: _bloc.name,
          onChanged: _bloc.changeName,
          hintText: userData[0].name,
          icon: "profile",
          obscureText: false,
        ),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Informações Privadas:",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Color(0xFF666666),
            ),
          ),
        ),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        Stack(
          children: <Widget>[
            SwappinInput(
              stream: _bloc.email,
              onChanged: _bloc.changeEmail,
              hintText: userData[0].email,
              icon: "email",
              obscureText: false,
            ),
            Container(
              height: 60,
              width: double.infinity,
              child: FlatButton(
                onPressed: () => userData[0].isSocialAuth != true
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => EditEmail(),
                        ),
                      )
                    : null,
                child: Text(""),
              ),
            ),
          ],
        ),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        SwappinInput(
          stream: _bloc.cpf,
          onChanged: _bloc.changeCpf,
          hintText: userData[0].cpf != "Não Informado"
              ? userData[0].cpf
              : "Inserir CPF",
          icon: "document-id",
          obscureText: false,
        ),
        Container(margin: EdgeInsets.only(top: 5, bottom: 5)),
        Expanded(child: Container()),
        submitButton(),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AdvancedSettings(),
                  ),
                );
              }, child: Text(
            "Configurações avançadas",

            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
              color: Colors.grey,
            ),
          ),
          ),
        ),
      ],
    );
  }

  Widget photoButton(String photo) {
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
                          ? Stack(
                              children: <Widget>[
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          photo,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  padding: EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Color(0x55000000),
                                  ),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    child: SwappinIcon(
                                      icon: "camera_1",
                                      firstColor: Colors.white,
                                      secondColor: Colors.white,
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ],
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
                    child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "Atualizar foto de perfil\n"),
                      TextSpan(
                        text: "Clique ao lado e sorria",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF05A9C7),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      },
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
          "Confirmar Alterações",
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
            'Confirmar Edição?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Color(
                0xFF00BFB2,
              ),
            ),
          ),
          content: const Text(
            'Tem certeza que deseja realizar as alterações?',
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
                    _bloc.updateUserData(image: _image).then(
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

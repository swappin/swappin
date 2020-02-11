import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/ui/widgets/sign-up-social.dart';
import 'package:swappin/src/ui/widgets/swappin-icon.dart';
import 'widgets/sign-up-form.dart';

class RegisterScreen extends StatefulWidget {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  RegisterScreen(
      {Key key,
      @required this.uid,
      this.email,
      this.displayName,
      this.photoUrl})
      : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState(
      uid: this.uid,
      email: this.email,
      displayName: this.displayName,
      photoUrl: this.photoUrl);
}

class _RegisterScreenState extends State<RegisterScreen> {
  String uid;
  String email;
  String displayName;
  String photoUrl;

  _RegisterScreenState({this.uid, this.email, this.displayName, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    print(this.email);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
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
            padding: EdgeInsets.symmetric(horizontal: 25),
            width: double.infinity,
            decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage("assets/background.jpg"),
//              fit: BoxFit.fill,
//            ),
                ),
            child: this.email != null
                ? SignUpSocial(
                    uid: this.uid,
                    email: this.email,
                    displayName: this.displayName,
                    photoUrl: this.photoUrl,
                  )
                : SignUpForm(),
          ),
        ),
      ),
    );
  }
}

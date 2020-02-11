import 'package:flutter/material.dart';
import 'package:swappin/src/blocs/login_bloc_provider.dart';
import 'package:swappin/src/ui/widgets/reset-form.dart';
class ResetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            child: ResetForm(),
          ),
        ),
      ),
    );
  }
}

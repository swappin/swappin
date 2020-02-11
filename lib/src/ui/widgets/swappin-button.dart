import 'package:flutter/material.dart';


class SwappinButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const SwappinButton({
    Key key,
    @required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          gradient: LinearGradient(colors: <Color>[Color(0xFF00C19F), Color(0xFF05A9C7)]),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
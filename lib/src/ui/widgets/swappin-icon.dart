import 'package:flutter/material.dart';

class SwappinIcon extends StatelessWidget {
  String icon;
  Color firstColor;
  Color secondColor;
  double width;
  double height;

  SwappinIcon({this.icon, this.firstColor, this.secondColor, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: <Color>[firstColor, secondColor],
            stops: [
              0.0,
              1.0,
            ],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
        child: Image.asset("assets/icons/black/$icon.png"),
      ),
    );
  }
}

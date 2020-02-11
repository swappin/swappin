import 'package:flutter/material.dart';

class ScoreStars extends StatefulWidget {
  final double score;
  ScoreStars(
      {Key key,
        @required this.score})
      : super(key: key);
  @override
  _ScoreStarsState createState() => _ScoreStarsState(
    score: this.score,
  );
}

class _ScoreStarsState extends State<ScoreStars> {

  double score;
  _ScoreStarsState({this.score});

  List<double> rectWidthList = [0, 0, 0, 0, 0];

  _scoreToStar(double score) {
    print("OH MY SCORE $score");
    double starWidth = (((score - score.floor()) * 100) * 40) / 100;
    setState(() {
      if (score < 1) {
        rectWidthList[0] = starWidth;
        print(starWidth);
      } else if (score < 2) {
        rectWidthList[0] = 40;
        rectWidthList[1] = starWidth;
        print(starWidth);
      } else if (score < 3) {
        rectWidthList[0] = 40;
        rectWidthList[1] = 40;
        rectWidthList[2] = starWidth;
        print(starWidth);
      } else if (score < 4) {
        rectWidthList[0] = 40;
        rectWidthList[1] = 40;
        rectWidthList[2] = 40;
        rectWidthList[3] = starWidth;
      } else if (score < 5) {
        rectWidthList[0] = 40;
        rectWidthList[1] = 40;
        rectWidthList[2] = 40;
        rectWidthList[3] = 40;
        rectWidthList[4] = starWidth;
      }else if(score == 5){
        rectWidthList[0] = 40;
        rectWidthList[1] = 40;
        rectWidthList[2] = 40;
        rectWidthList[3] = 40;
        rectWidthList[4] = 40;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scoreToStar(score);
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 22.0,
        child: Row(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: rectWidthList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(2.0),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF00BFB2),
                            Color(0xFF999999)
                          ],
                          stops: [
                            0.5,
                            0.5
                          ]).createShader(Rect.fromLTRB(0, 0,
                          rectWidthList[index], rect.height));
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.asset(
                      'assets/icons/black/star_favorite_1.png',
                      height: 18,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                score.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF777777),
                ),
              ),
            )
          ],
        ),
      );
  }
}

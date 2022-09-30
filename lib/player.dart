import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  MyPlayer(this.playerX);
  final playerX;
  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: Alignment(playerX,1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image(image:
            AssetImage('images/bubble.png'),

            height: 70,
            width: 70,
          ),
        ),

    );
  }
}

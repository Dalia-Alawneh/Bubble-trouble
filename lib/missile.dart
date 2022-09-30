import 'package:flutter/material.dart';
class MyMissile extends StatelessWidget {
  const MyMissile(this.height, this.missileX);
  final height;
  final missileX;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, 1),
      child: Container(
        width: 2,
        height: height,
        color: Colors.grey,
      ),
    );
  }
}


import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(this.icon, this.function);
  IconData icon;
  final function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
          width: 50,
          height: 50,
          child: Center(child:Icon(icon)),
        ),
      ),
    );
  }
}

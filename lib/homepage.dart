import 'dart:async';

import 'package:bubbletrouble/button.dart';
import 'package:bubbletrouble/player.dart';
import 'package:flutter/material.dart';

import 'ball.dart';
import 'missile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  static double playerX = 0;
  double missileX = playerX;
  bool midShot = false;
  double missileHeight = 10;
  double ballX = 0.5;
  double ballY = 1;
  var ballDirection = direction.LEFT;
  void moveLeft() {
    setState(() {
      if (playerX - 0.1 < -1) {
      } else {
        playerX -= 0.1;
      }
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.1 > 1) {
      } else {
        playerX += 0.1;
      }
      missileX = playerX;
    });
  }

  void fireMissile() {
    if (midShot == false) {
      Timer.periodic(Duration(microseconds: 10), (timer) {
        midShot = true;
        setState(() {
          missileHeight += 10;
        });
        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }
        if (ballY > heightToPosition(missileHeight) &&
            (ballX - missileX).abs() < 0.03) {
          resetMissile();
          ballX = 10;
          timer.cancel();
          showDialog(context: context, builder:( BuildContext context){
            return AlertDialog(
              title: Text('You win 🥳'),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                  ballX = 0.5;
                  ballY = 1;
                  startGame();
                }, child: Text("Play Again"))
              ],
            );
          });
        }
      });
    }
  }

  void resetMissile() {
    missileX = playerX;
    missileHeight = 10;
    midShot = false;
  }

  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 50;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = -5 * time * time + velocity * time;
      if (height < 0) {
        time = 0;
      }
      setState(() {
        ballY = heightToPosition(height);
      });

      if (ballX - 0.02 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX + 0.02 > 1) {
        ballDirection = direction.LEFT;
      }
      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.02;
        });
      } else {
        setState(() {
          ballX += 0.02;
        });
      }

      if (playerDies()) {
        timer.cancel();
        showGameOverScreen();
        ballX = 0.5;
        ballY =1;
        time =0;
      }
      time += 0.1;
    });
  }

  void showGameOverScreen() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You Are Dead Bro!🥺🙂'),
            actions: <Widget>[
              ElevatedButton(
                child: Text("Try Again..👊🏻"),
                onPressed: () {
                  Navigator.of(context).pop();
                  startGame();
                },
              ),
            ],
          );
        });
  }

  double heightToPosition(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double position = 1 - 2 * height / totalHeight;
    return position;
  }

  bool playerDies() {
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink[200],
              child: Center(
                child: Stack(
                  children: [
                    MyBall(ballX, ballY),
                    MyMissile(missileHeight, missileX),
                    MyPlayer(playerX),
                  ],
                ),
              ),
            )),
        Expanded(
            child: Container(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(Icons.play_arrow, startGame),
              MyButton(Icons.arrow_back, moveLeft),
              MyButton(Icons.arrow_upward, fireMissile),
              MyButton(Icons.arrow_forward, moveRight),
            ],
          ),
        )),
      ],
    );
  }
}

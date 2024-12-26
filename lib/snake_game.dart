// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

enum Direction { up, right, down, left }

class _SnakeGameState extends State<SnakeGame> {
  int nRow = 38, nCol = 21;

  List<int> borderList = [];
  List<int> snakePosition = [];
  int snakeHead = 0;
  int score = 0;
  late int foodPosition;
  late FocusNode focusnode;
  late Direction direction;

  @override
  void initState() {
    super.initState();
    focusnode = FocusNode();
    startGame();
  }

  @override
  void dispose() {
    focusnode.dispose();
    super.initState();
  }

  void startGame() {
    setState(() {
      score = 0;
      makeBorder();
      generateFood();
      direction = Direction.right;
      snakePosition = [50, 49, 48];
      snakeHead = snakePosition.first;
    });

    Timer.periodic(Duration(milliseconds: 300), (timer) {
      updateSnake();
      if (checkCollission()) {
        timer.cancel();
        showDialogBox();
      }
    });
  }

  void showDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over!!!'),
          content: Text('Your final Score is: $score',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  startGame();
                },
                child: Text('Restart!'))
          ],
        );
      },
    );
  }

  bool checkCollission() {
    if (borderList.contains(snakeHead)) return true;
    if (snakePosition.sublist(1).contains(snakeHead)) return true;
    return false;
  }

  void generateFood() {
    foodPosition = Random().nextInt(nRow * nCol);
    if (borderList.contains(foodPosition) ||
        snakePosition.contains(foodPosition)) {
      generateFood();
    }
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case Direction.up:
          snakePosition.insert(0, snakeHead - nCol);
          break;
        case Direction.right:
          snakePosition.insert(0, snakeHead + 1);
          break;
        case Direction.down:
          snakePosition.insert(0, snakeHead + nCol);
          break;
        case Direction.left:
          snakePosition.insert(0, snakeHead - 1);
          break;
      }
    });

    if (snakeHead == foodPosition) {
      score++;
      generateFood();
    } else {
      snakePosition.removeLast();
    }
    snakeHead = snakePosition.first;
  }

  void handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          if (direction != Direction.down) {
            direction = Direction.up;
          }
          break;
        case LogicalKeyboardKey.arrowDown:
          if (direction != Direction.up) {
            direction = Direction.down;
          }
          break;
        case LogicalKeyboardKey.arrowLeft:
          if (direction != Direction.right) {
            direction = Direction.left;
          }
          break;
        case LogicalKeyboardKey.arrowRight:
          if (direction != Direction.left) {
            direction = Direction.right;
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Text(
          'Snake Game',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.blue[100],
      body: SafeArea(
          child: RawKeyboardListener(
        focusNode: focusnode,
        onKey: handleKey,
        autofocus: true,
        child: Column(
          children: [
            Text(
              'Score: $score',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            Expanded(
              child: groundforSnake(),
            )
          ],
        ),
      )),
    );
  }

  Widget groundforSnake() {
    return GridView.builder(
        itemCount: nRow * nCol,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: nCol),
        itemBuilder: (context, index) {
          return Container(
              color: boxFillColor(index),
              margin: EdgeInsets.only(right: 1, bottom: 1));
        });
  }

  Color boxFillColor(int index) {
    if (borderList.contains(index)) {
      return Colors.green;
    } else {
      if (snakePosition.contains(index)) {
        if (snakeHead == index) {
          return Colors.red;
        } else {
          return Colors.black45;
        }
      } else {
        if (index == foodPosition) {
          return Colors.green;
        }
      }
    }
    return Colors.white60;
  }

  void makeBorder() {
    borderList.clear();
    for (int i = 0; i < nCol; i++) {
      borderList.add(i);
    }
    for (int i = 0; i < nRow * nCol; i += nCol) {
      borderList.add(i);
    }
    for (int i = nCol - 1; i < nRow * nCol; i += nCol) {
      borderList.add(i);
    }
    for (int i = (nRow * nCol) - nCol; i < nRow * nCol; i++) {
      borderList.add(i);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:game_demo/snake_game.dart';

import 'tic_tac_toe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SafeArea(
        child: Container(
            padding: EdgeInsets.all(kWidth * 0.1),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Welcome to Song\'s Game',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.yellowAccent,
                    )),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SnakeGame()),
                        );
                      },
                      child: Text('Snake Game'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TicTacToeGame()),
                        );
                      },
                      child: Text('Tik_tac_toe Game'),
                    )
                  ],
                ),
              ],
            )),
      )),
    );
  }
}

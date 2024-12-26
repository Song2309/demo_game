import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  final List<String> board = List.filled(9, '');

  String currentPlayer = 'X';
  String winner = '';
  bool isTie = false;
  String player1 = '';
  String player2 = '';
  String player3 = '';

  player(int index) {
    if (winner != '' || board[index] != '') {
      return;
    }
    setState(() {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      checkforWinner();
    });
  }

  void checkforWinner() {
    List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> line in lines) {
      player1 = board[line[0]];
      player2 = board[line[1]];
      player3 = board[line[2]];
      if (player1 == '' || player2 == '' || player3 == '') {
        continue;
      }
      if (player1 == player2 && player2 == player3) {
        setState(() {
          winner = player1;
        });
        return;
      }
    }
    if (!board.contains('')) {
      setState(() {
        isTie = true;
      });
    }
  }

  resetGame() {
    setState(() {
      board.fillRange(0, 9, '');
      currentPlayer = 'X';
      winner = '';
      isTie = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Tic - tac - toe Game',
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
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: currentPlayer == 'X'
                          ? Colors.amber
                          : Colors.transparent),
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)],
                ),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 55,
                        ),
                        SizedBox(height: 10),
                        Text('Player 1',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        Text('X',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.red,
                                fontWeight: FontWeight.w400)),
                      ],
                    )),
              ),
              SizedBox(width: size.width * 0.08),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: currentPlayer == 'O'
                          ? Colors.amber
                          : Colors.transparent),
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)],
                ),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 55,
                        ),
                        SizedBox(height: 10),
                        Text('Player 2',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        Text('O',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeight.w400)),
                      ],
                    )),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          if (winner != '')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner,
                  style: TextStyle(
                      fontSize: 35,
                      color: winner == 'X' ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  ' Won!!!',
                  style: TextStyle(
                      fontSize: 35,
                      color: winner == 'X' ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          if (isTie)
            Text(
              'It\'s a tie game',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    player(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                            fontSize: 50,
                            color: board[index] == 'X'
                                ? Colors.red
                                : Colors.green),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (winner != '' || isTie)
            ElevatedButton(onPressed: resetGame, child: Text('Play again!!!')),
        ],
      ),
    );
  }
}

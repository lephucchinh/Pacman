import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pacman_game/path.dart';
import 'package:pacman_game/pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int player = numberInRow * 15 + 1;
  int numberOfSquares = numberInRow * 17;

  bool gameStarted = true;
  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    21,
    32,
    43,
    54,
    65,
    76,
    87,
    78,
    79,
    80,
    81,
    70,
    59,
    86,
    85,
    84,
    83,
    72,
    61,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    26,
    37,
    38,
    39,
    28,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    100,
    101,
    102,
    103,
    114,
    125,
    108,
    107,
    106,
    105,
    116,
    127,
    158,
    147,
    148,
    149,
    160,
    123,
    134,
    145,
    156,
    129,
    140,
    151,
    162
  ];
  String direction = 'right';

  List<int> food =[];


  void startGame() {
    getFood();
    Timer.periodic(Duration(milliseconds: 500), (timer) {

      if(food.contains(player)) {
        food.remove(player);
      }

      switch (direction) {
        case 'left':
          moveLeft();
          break;
        case 'right':
          moveRight();
          break;
        case 'up':
          moveUp();
          break;
        case 'down':
          moveDown();
          break;
        default:
      }
    });
  }

  void getFood() {
    for(int i = 0 ; i < numberOfSquares ; i++ ) {
      if(!barriers.contains(i)){
        food.add(i);
      }
    }
  }

  void moveLeft() {
    if(player == 88){
      player = 98;
    }
    if (!barriers.contains(player - 1)) {
      setState(() {
        player= player - 1;


      });
    }
  }
  void moveRight() {
    if(player == 98){
      player = 88;
    }
    if (!barriers.contains(player + 1)) {
      setState(() {
        player= player + 1;
        if(player == 98){
          player = 88;
        }
      });
    }
  }
  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }
  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy < 0) {
                  direction = 'up';
                  log(direction);
                } else if (details.delta.dy > 0) {
                  direction = 'down';
                  log(direction);
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx < 0) {
                  direction = 'left';
                  log(direction);
                } else if (details.delta.dx > 0) {
                  direction = 'right';
                  log(direction);
                }
              },
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext context, int index) {
                      // pacman player
                      if (player == index) {
                        switch (direction) {
                          case 'up':
                            return Transform.rotate(
                              angle: -90 * 3.1415927 / 180,
                              child: Image.asset(
                                'assets/Pacman.svg.png',
                                fit: BoxFit.fill,
                              ),
                            );
                            break;
                          case 'down':
                            return Transform.rotate(
                              angle: 90 * 3.1415927 / 180,
                              child: Image.asset(
                                'assets/Pacman.svg.png',
                                fit: BoxFit.fill,
                              ),
                            );
                            break;
                          case 'left':
                            return Transform.rotate(
                              angle: -180 * 3.1415927 / 180,
                              child: Image.asset(
                                'assets/Pacman.svg.png',
                                fit: BoxFit.fill,
                              ),
                            );
                            break;
                          case 'right':
                            return Transform.rotate(
                              angle: 0,
                              child: Image.asset(
                                'assets/Pacman.svg.png',
                                fit: BoxFit.fill,
                              ),
                            );

                        };
                      }
                      // tường thành
                      else if (barriers.contains(index)) {
                        return Padding(
                          padding: EdgeInsets.all(1.0),
                          child: MyPixel(
                            innerColor: Colors.blue[800],
                            outerColor: Colors.blue[900],
                          ),
                        );
                      }
                      // đường di chuyển
                      else  {
                        return Padding(
                          padding: EdgeInsets.all(1.0),
                          child: MyPath(),
                        );
                      }
                    }),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    direction = 'pause';
                  },
                  child: Text(
                    'pause',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Text(
                  'Score: 14',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    startGame();
                  },
                  child: Text(
                    'Play',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

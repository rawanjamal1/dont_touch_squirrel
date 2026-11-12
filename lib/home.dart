import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'components/button.dart';
import 'components/mode.dart';
import 'components/game.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int page = 0;
  bool soundOn = true;

  String selectedMode = 'Classic';

  int score = 0;
  int lives = 3;
  int seconds = 60;

  int acorn = -1;
  int squirrel = -1;

  final Random random = Random();

  Timer? moveTimer;
  Timer? countdown;

  void showInstructions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('How to Play'),
          content: const Text(
            'Catch the acorns to earn 10 points!\n\n'
            'Avoid touching the squirrel.\n\n'
            'Classic: Touching the squirrel ends the game.\n\n'
            'Time Attack: You have 60 seconds. '
            'Touching the squirrel removes 5 seconds.\n\n'
            'Survival: You have 3 lives.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void openModes() {
    stopTimers();

    setState(() {
      page = 1;
    });
  }

  void openHome() {
    stopTimers();

    setState(() {
      page = 0;
    });
  }

  void startGame(String mode) {
    stopTimers();

    setState(() {
      selectedMode = mode;
      page = 2;
      score = 0;
      lives = 3;
      seconds = 60;
      acorn = -1;
      squirrel = -1;
    });

    moveObjects();

    moveTimer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (timer) {
        moveObjects();
      },
    );

    if (mode == 'Time Attack') {
      countdown = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (!mounted || page != 2) {
            timer.cancel();
            return;
          }

          setState(() {
            seconds--;
          });

          if (seconds <= 0) {
            endGame();
          }
        },
      );
    }
  }

  void moveObjects() {
    if (!mounted || page != 2) {
      return;
    }

    int newAcorn = random.nextInt(16);
    int newSquirrel = random.nextInt(16);

    while (newSquirrel == newAcorn) {
      newSquirrel = random.nextInt(16);
    }

    setState(() {
      acorn = newAcorn;
      squirrel = newSquirrel;
    });
  }

  void tapHole(int index) {
    if (page != 2) {
      return;
    }

    if (index == acorn) {
      setState(() {
        score += 10;
        acorn = -1;
      });
      return;
    }

    if (index == squirrel) {
      if (selectedMode == 'Classic') {
        endGame();
      } else if (selectedMode == 'Time Attack') {
        setState(() {
          seconds = max(0, seconds - 5);
          squirrel = -1;
        });

        if (seconds <= 0) {
          endGame();
        }
      } else if (selectedMode == 'Survival') {
        setState(() {
          lives--;
          squirrel = -1;
        });

        if (lives <= 0) {
          endGame();
        }
      }
    }
  }

  void endGame() {
    if (page != 2) {
      return;
    }

    stopTimers();

    setState(() {
      page = 3;
    });
  }

  void stopTimers() {
    moveTimer?.cancel();
    countdown?.cancel();

    moveTimer = null;
    countdown = null;
  }

  @override
  void dispose() {
    stopTimers();
    super.dispose();
  }

  Widget buildHome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "DON'T TOUCH THE SQUIRREL!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Catch the Acorns 🌰',
          style: TextStyle(
            fontSize: 20,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 35),
        const Text(
          '🐿️',
          style: TextStyle(fontSize: 90),
        ),
        const SizedBox(height: 35),
        GameButton(
          text: 'PLAY GAME',
          onPressed: openModes,
        ),
        const SizedBox(height: 12),
        GameButton(
          text: 'HOW TO PLAY',
          onPressed: showInstructions,
        ),
        const SizedBox(height: 12),
        GameButton(
          text: soundOn ? 'SOUND ON' : 'SOUND OFF',
          onPressed: () {
            setState(() {
              soundOn = !soundOn;
            });
          },
        ),
      ],
    );
  }

  Widget buildModes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'CHOOSE YOUR MODE',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 30),
        Mode(
          title: 'CLASSIC',
          description: 'Touch Nutty and the game is over!',
          onPressed: () {
            startGame('Classic');
          },
        ),
        const SizedBox(height: 15),
        Mode(
          title: 'TIME ATTACK',
          description: 'Catch acorns in 60 seconds!',
          onPressed: () {
            startGame('Time Attack');
          },
        ),
        const SizedBox(height: 15),
        Mode(
          title: 'SURVIVAL',
          description: 'You have 3 lives!',
          onPressed: () {
            startGame('Survival');
          },
        ),
        const SizedBox(height: 30),
        GameButton(
          text: 'BACK',
          onPressed: openHome,
        ),
      ],
    );
  }

  Widget buildGame() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          selectedMode.toUpperCase(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'SCORE: $score',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (selectedMode == 'Survival')
          Text(
            'LIVES: $lives ❤️',
            style: const TextStyle(fontSize: 22),
          ),
        if (selectedMode == 'Time Attack')
          Text(
            'TIME: $seconds',
            style: const TextStyle(fontSize: 22),
          ),
        const SizedBox(height: 25),
        SizedBox(
          width: 360,
          height: 360,
          child: Game(
            acorn: acorn,
            squirrel: squirrel,
            onTap: tapHole,
          ),
        ),
        const SizedBox(height: 25),
        GameButton(
          text: 'BACK',
          onPressed: openModes,
        ),
      ],
    );
  }

  Widget buildGameOver() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'GAME OVER!',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          '🐿️',
          style: TextStyle(fontSize: 90),
        ),
        const SizedBox(height: 20),
        Text(
          'YOUR SCORE: $score',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        GameButton(
          text: 'PLAY AGAIN',
          onPressed: () {
            startGame(selectedMode);
          },
        ),
        const SizedBox(height: 12),
        GameButton(
          text: 'CHOOSE MODE',
          onPressed: openModes,
        ),
        const SizedBox(height: 12),
        GameButton(
          text: 'HOME',
          onPressed: openHome,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    if (page == 0) {
      currentPage = buildHome();
    } else if (page == 1) {
      currentPage = buildModes();
    } else if (page == 2) {
      currentPage = buildGame();
    } else {
      currentPage = buildGameOver();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFE6B3),
      body: SafeArea(
        child: Center(
          child: currentPage,
        ),
      ),
    );
  }
}

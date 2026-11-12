import 'package:flutter/material.dart';
import 'components/button.dart';
import 'components/mode.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool soundOn = true;
  bool showModes = false;

  void showInstructions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('How to Play'),
          content: const Text(
            'Catch the acorns to earn points!\n\n'
            'Avoid touching the squirrel.\n\n'
            'Classic: One wrong tap ends the game.\n\n'
            'Time Attack: You have 60 seconds.\n\n'
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
          onPressed: () {
            setState(() {
              showModes = true;
            });
          },
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
          description: 'One wrong tap and the game is over!',
          onPressed: () {
            // Game will be added next.
          },
        ),
        const SizedBox(height: 15),
        Mode(
          title: 'TIME ATTACK',
          description: 'Catch acorns in 60 seconds!',
          onPressed: () {
            // Game will be added next.
          },
        ),
        const SizedBox(height: 15),
        Mode(
          title: 'SURVIVAL',
          description: 'You have 3 lives!',
          onPressed: () {
            // Game will be added next.
          },
        ),
        const SizedBox(height: 30),
        GameButton(
          text: 'BACK',
          onPressed: () {
            setState(() {
              showModes = false;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6B3),
      body: SafeArea(
        child: Center(
          child: showModes ? buildModes() : buildHome(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool soundOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6B3),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                ElevatedButton(
                  onPressed: () {
                    // We will add the game modes here.
                  },
                  child: const Text('PLAY GAME'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // We will add instructions here.
                  },
                  child: const Text('HOW TO PLAY'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      soundOn = !soundOn;
                    });
                  },
                  child: Text(
                    soundOn ? 'SOUND ON' : 'SOUND OFF',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

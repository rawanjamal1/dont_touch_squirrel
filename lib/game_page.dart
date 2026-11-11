import 'package:flutter/material.dart';

enum GameScreen { home, modes }

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameScreen screen = GameScreen.home;
  bool soundOn = true;

  void showInstructions() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to Play 🌰'),
        content: const Text(
          'Tap the acorns to earn points.\n'
          'Normal acorn: +10 points.\n'
          'Golden acorn: +30 points.\n'
          'Avoid touching Nutty the squirrel!\n\n'
          'Classic: One mistake ends the game.\n'
          'Time Attack: Play for 60 seconds.\n'
          'Survival: You have 3 hearts.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void chooseMode(String mode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$mode selected! Gameplay comes in Phase 2.')),
    );
  }

  Widget woodenButton(String text, VoidCallback onTap, {Color? color}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color(0xFF875632),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
            side: const BorderSide(color: Color(0xFF5C3823), width: 2),
          ),
        ),
        child: Text(text, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget modeCard(String title, String description, IconData icon, Color color) {
    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => chooseMode(title),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFFFE8B4), size: 30),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(description, style: const TextStyle(
                      fontSize: 13, color: Color(0xFFFFE9CA))),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/forest.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: screen == GameScreen.home ? buildHome() : buildModes(),
          ),
        ),
      ),
    );
  }

  Widget buildHome() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text("DON'T TOUCH THE", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900,
                color: Color(0xFF49301C), shadows: [
                  Shadow(color: Colors.white, blurRadius: 9),
                ])),
        const Text('SQUIRREL!', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 43, fontWeight: FontWeight.w900,
                color: Color(0xFFB95116), shadows: [
                  Shadow(color: Colors.white, blurRadius: 9),
                ])),
        const Text('Catch the Acorns 🌰',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                color: Color(0xFF49301C))),
        const Spacer(),
        const Text('🐿️', style: TextStyle(fontSize: 110)),
        const Spacer(),
        woodenButton('▶  PLAY GAME', () {
          setState(() => screen = GameScreen.modes);
        }, color: const Color(0xFF547D28)),
        const SizedBox(height: 12),
        woodenButton('HOW TO PLAY', showInstructions),
        const SizedBox(height: 12),
        woodenButton(soundOn ? '🔊 SOUND ON' : '🔇 SOUND OFF', () {
          setState(() => soundOn = !soundOn);
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildModes() {
    return Column(
      children: [
        const SizedBox(height: 25),
        const Text('Choose Your Adventure!', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900,
                color: Color(0xFF4E3828), shadows: [
                  Shadow(color: Colors.white, blurRadius: 12),
                ])),
        const Spacer(),
        modeCard('CLASSIC', 'One wrong tap and Nutty wins!',
            Icons.all_inclusive, const Color(0xFFA57446)),
        const SizedBox(height: 15),
        modeCard('TIME ATTACK', '60 seconds. Catch as many as you can!',
            Icons.timer, const Color(0xFF92633E)),
        const SizedBox(height: 15),
        modeCard('SURVIVAL', 'Three hearts. How long can you survive?',
            Icons.favorite, const Color(0xFF795436)),
        const Spacer(),
        woodenButton('← BACK', () {
          setState(() => screen = GameScreen.home);
        }),
        const SizedBox(height: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:snake_game/game/presentation/game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 20,
          title: const Text(
            'Snake Game',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cupIcon(),
                  const Text(
                    ' High Score ',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  cupIcon(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '36',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,color: Colors.red),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 75,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, GameScreen.routeNamed);
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  cupIcon() {
    return const Icon(
      Icons.emoji_events_outlined,
      size: 60,
    );
  }
}

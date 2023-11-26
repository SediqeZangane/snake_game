import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_game/game/presentation/game_screen.dart';
import 'package:snake_game/main.dart';

class HomeScreen extends StatefulWidget {
  static const String routeNamed = 'homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    setState(() {});
  }

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
              FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (BuildContext context,
                      AsyncSnapshot<SharedPreferences> snapshot) {
                    return Text(
                      '${snapshot.data?.getInt('highScore') ?? 0}',
                      style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    );
                  }),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/presentation/game_screen.dart';
import 'package:snake_game/home/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

// global RouteObserver
final RouteObserver<Route> routeObserver = RouteObserver<Route>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.routeNamed,
      navigatorObservers: <NavigatorObserver>[routeObserver],
      routes: {
        GameScreen.routeNamed: (context) => BlocProvider<GameBloc>(
            create: (context) {
              return GameBloc()..add(GameInitEvent());
            },
            child: const GameScreen()),
        HomeScreen.routeNamed: (context) => const HomeScreen()
      },
    );
  }
}

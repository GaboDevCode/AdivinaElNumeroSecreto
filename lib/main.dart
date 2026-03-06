import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_adivina_el_numero/viewmodels/game_viewmodel.dart';
import 'package:reto_adivina_el_numero/views/game_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _AdivinaElnumeroState();
}

class _AdivinaElnumeroState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: GameView()
    );
  }
}

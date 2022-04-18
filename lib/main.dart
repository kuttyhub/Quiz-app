import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

import './Screens/quiz/quiz_screen.dart';
import './Screens/score_screen.dart';
import './Screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        backgroundColor: kBackgroundColor,
      ),
      home: WelcomeScreen(),
      routes: {
        QuizScreen.routeName: (context) => QuizScreen(),
        ScoreScreen.routeName: (context) => ScoreScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './quiz/quiz_screen.dart';
import '../constants.dart';

// ignore: must_be_immutable
class ScoreScreen extends StatelessWidget {
  static const routeName = '/ScoreScreen';
  var correctAns;
  var noOfQuestions;
  var greetings = {
    "0": "It's Ok..Keep Trying",
    "10": "You will nail it the next Time",
    "20": "You can do Better",
    "40": "Oops..that's a slight miss",
    "50": "You did a good job",
    "70": "You are Awesome",
    "80": "Your are Fantastic",
    "90": "You Nailed it",
  };
  String getGreetings() {
    var percent = correctAns / noOfQuestions * 100;
    if (percent > 90) {
      return greetings["90"];
    } else if (percent > 80) {
      return greetings["80"];
    } else if (percent > 70) {
      return greetings["70"];
    } else if (percent > 50) {
      return greetings["50"];
    } else if (percent > 40) {
      return greetings["40"];
    } else if (percent > 20) {
      return greetings["20"];
    } else if (percent > 10) {
      return greetings["10"];
    } else {
      return greetings["0"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arg = ModalRoute.of(context).settings.arguments;
    correctAns = arg['correctAns'];
    noOfQuestions = arg["noOfquestions"];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kBackgroundColor,
              ),
            ),
            Column(
              children: [
                Spacer(flex: 3),
                Text(
                  "Congratulations!",
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${arg["userName"] ?? ""}",
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.white,
                        
                      ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Text(
                  "YOUR SCORE",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: kSecondaryColor,
                      ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: RichText(
                    text: TextSpan(
                      text: "${correctAns * 10}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.tealAccent),
                      children: [
                        TextSpan(
                          text: "/${noOfQuestions * 10}",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  getGreetings(),
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Spacer(flex: 2),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .popAndPushNamed(QuizScreen.routeName),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding / 2),
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: kPrimaryGradient,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Text(
                            "Restart Game",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: kBackgroundColor),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => SystemNavigator.pop(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            //gradient: kPrimaryGradient,
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Text(
                            "Exit",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: kBackgroundColor),
                          ),
                        ),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                ),
                Spacer(flex: 3),
              ],
            )
          ],
        ),
      ),
    );
  }
}

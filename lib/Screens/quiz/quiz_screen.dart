import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './components/correct_option.dart';
import './components/defalut_option.dart';
import './components/wrong_option.dart';
import '../score_screen.dart';
import '../../models/question.dart';
import '../../constants.dart';
import './components/progress_bar.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz-screen';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animController;
  Animation<double> _animation;
  String _userName;
  var _questionVal = 1;
  var isAnswered = false;
  int correctAns;
  int selectedAns;
  int correctAnswered = 0;
  List<Question> _questions = [];

  void updateTheQnNum(int index) {
    _questionVal = index + 1;
  }

  void checkAns(int index, int selectedIndex) {
    //print("index : $index select:$selectedIndex");
    setState(() {
      isAnswered = true;
      correctAns = _questions[index].correctIndex;
      selectedAns = selectedIndex;
      if (correctAns == selectedIndex) {
        correctAnswered += 1;
      }
      _animController.stop();
      Future.delayed(Duration(seconds: 3), () {
        nextQuestion();
      });
    });
  }

  void nextQuestion() {
    //print("nextQuestion $_questionVal of ${_questions.length}");
    if (_questionVal != _questions.length) {
      isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      _animController.reset();
      _animController.forward().whenComplete(nextQuestion);
    } else {
      Navigator.of(context).popAndPushNamed(ScoreScreen.routeName, arguments: {
        "correctAns": correctAnswered,
        "noOfquestions": _questions.length,
        "userName": _userName,
      });
    }
  }

  void resetQuiz(BuildContext context) {
    isAnswered = false;
    Navigator.pop(context);
  }

  Widget getTheRightColor({int index, String text, Function press}) {
    if (isAnswered) {
      if (index == correctAns) {
        return CorrectOption(
          index: index,
          text: text,
          press: press,
        );
      } else if (index == selectedAns && selectedAns != correctAns) {
        return WrongOption(
          index: index,
          text: text,
          press: press,
        );
      }
    }
    return DefaultOption(
      index: index,
      text: text,
      press: press,
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _userName = ModalRoute.of(context).settings.arguments;
    });
    _animController = AnimationController(
      duration: Duration(seconds: 60),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animController)
      ..addListener(() {
        setState(() {});
      });
    _animController.forward();
    _animController.forward().whenComplete(nextQuestion);
    _pageController = PageController();

    setQuestions();
    super.initState();
  }
void setQuestions() async{
  final String response = await rootBundle.loadString('assets/questions.json');
  List<Question> questions = questionFromJson(response);
  setState(() {
   _questions= questions;
  });
}
  @override
  void dispose() {
    _animController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: InkWell(
                onTap: nextQuestion,
                child: Text(
                  "skip",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              color: kBackgroundColor,
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: ProgressBar(_animation),
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: RichText(
                      text: TextSpan(
                        text: "Question $_questionVal",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: kSecondaryColor),
                        children: [
                          TextSpan(
                            text: "/${_questions.length}",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: kSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1.5),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2 * kDefaultPadding),
                      child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: updateTheQnNum,
                        itemBuilder: (ctx, index) => Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          //alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _questions[index].question,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: kBlackColor),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                          _questions[index].answers.length,
                                          (inx) => getTheRightColor(
                                            index: inx,
                                            text: _questions[index].answers[inx],
                                            press: () => checkAns(index, inx),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        itemCount: _questions.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

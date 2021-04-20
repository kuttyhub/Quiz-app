import 'package:flutter/material.dart';
import './quiz/quiz_screen.dart';
import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController _nameController = TextEditingController();
  String errorText;

  void validateName() {
    setState(() {
      if (_nameController.text.length < 4 || _nameController.text.isEmpty) {
        errorText = "Name should contain more than 4 characters";
      } else {
        removeFocus();
        errorText = null;
        Navigator.of(context)
            .pushNamed(QuizScreen.routeName, arguments: _nameController.text);
      }
    });
  }

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: removeFocus,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kBackgroundColor,
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  children: [
                    Spacer(flex: 2),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Text(
                        "Let's Play Quiz,",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    const Text("Enter your informations below"),
                    SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xff1c2341),
                        hintText: "Full name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        errorText: errorText,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: validateName,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                        decoration: BoxDecoration(
                          gradient: kPrimaryGradient,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          "Lets Start Quiz",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

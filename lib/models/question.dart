import 'dart:convert';
List<Question> questionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));


class Question {
  final String question;
  final List<String> answers;
  final int correctIndex;

  Question({this.question, this.answers, this.correctIndex});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answers: List<String>.from(json["answers"].map((x) => x)),
        correctIndex: json["correctIndex"],
      );
}

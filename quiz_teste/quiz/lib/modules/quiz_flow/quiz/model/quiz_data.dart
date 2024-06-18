// To parse this JSON data, do
//
//     final quizDataModel = quizDataModelFromJson(jsonString);

import 'dart:convert';

QuizDataModel quizDataModelFromJson(String str) =>
    QuizDataModel.fromJson(json.decode(str));

String quizDataModelToJson(QuizDataModel data) => json.encode(data.toJson());

class QuizDataModel {
  String ajuda;
  List<Question> questions;

  QuizDataModel({
    required this.ajuda,
    required this.questions,
  });

  factory QuizDataModel.fromJson(Map<String, dynamic> json) => QuizDataModel(
        ajuda: json["ajuda"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ajuda": ajuda,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  String question;
  List<Answer> answers;

  Question({
    required this.question,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class Answer {
  String resposta;
  bool correta;

  Answer({
    required this.resposta,
    required this.correta,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        resposta: json["resposta"],
        correta: json["correta"],
      );

  Map<String, dynamic> toJson() => {
        "resposta": resposta,
        "correta": correta,
      };
}

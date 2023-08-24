import 'package:red_squirrel/utils/constants/classes.dart';

class QuizModel {
  final List<Quiz>? quizzes;
  final List<List<String>>? answers;

  QuizModel({
    this.quizzes,
    this.answers,
  });

  QuizModel copyWith({
    List<Quiz>? quizzes,
    List<List<String>>? answers,
  }) {
    return QuizModel(
        quizzes: quizzes ?? this.quizzes, answers: answers ?? this.answers);
  }

  factory QuizModel.fromSnapsot(Map<String, dynamic> snapshot) {
    return QuizModel(
      quizzes: List<Quiz>.from(
          snapshot['quizzes'].map((i) => Quiz.fromJson(i)).toList() ?? []),
      answers: List<List<String>>.from(snapshot['answers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        'quizzes': quizzes!.map((e) => e.toJson()).toList(),
        'answers': answers,
      };
}

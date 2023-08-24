part of 'quiz_bloc.dart';

enum QuizStatus { initial, loading, empty, success, failure }

@immutable
class QuizState extends Equatable {
  final QuizModel quiz;
  final QuizStatus status;

  const QuizState({required this.quiz, this.status = QuizStatus.initial});

  QuizState copyWith({
    QuizModel? quiz,
    QuizStatus? status,
  }) {
    return QuizState(quiz: quiz ?? this.quiz, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status, quiz];
}

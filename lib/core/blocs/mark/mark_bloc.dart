// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:red_squirrel/core/models/mark_model.dart';
import 'package:red_squirrel/services/mark.dart';
import 'package:red_squirrel/utils/constants/classes.dart';

part 'mark_event.dart';
part 'mark_state.dart';

class MarkBloc extends Bloc<MarkEvent, MarkState> {
  MarkBloc() : super(MarkState(mark: MarkModel(), status: MarkStatus.initial)) {
    on<MarkLoadRequested>((event, emit) async {
      try {
        emit(state.copyWith(
          status: MarkStatus.loading,
        ));
        List<Mark> marks = await getMarks();
        MarkModel mark = MarkModel(marks: marks);
        emit(state.copyWith(
          status: MarkStatus.success,
          mark: mark,
        ));
      } catch (e) {
        emit(state.copyWith(status: MarkStatus.failure));
      }
    });
    // on<QuizUpdated>((event, emit) async {
    //   emit(state.copyWith(quiz: event.quiz));
    // });
  }
}

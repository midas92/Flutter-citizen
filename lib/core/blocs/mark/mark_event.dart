part of 'mark_bloc.dart';

abstract class MarkEvent extends Equatable {
  const MarkEvent();

  @override
  List<Object> get props => [];
}

class MarkLoaded extends MarkEvent {
  final MarkModel mark;

  const MarkLoaded(this.mark);

  @override
  List<Object> get props => [mark];
}

class MarkLoadRequested extends MarkEvent {
  const MarkLoadRequested();

  @override
  List<Object> get props => [];
}
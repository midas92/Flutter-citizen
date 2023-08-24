part of 'mark_bloc.dart';

enum MarkStatus { initial, loading, empty, success, failure }

@immutable
class MarkState extends Equatable {
  final MarkModel mark;
  final MarkStatus status;

  const MarkState({required this.mark, this.status = MarkStatus.initial});

  MarkState copyWith({
    MarkModel? mark,
    MarkStatus? status,
  }) {
    return MarkState(mark: mark ?? this.mark, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status, mark];
}

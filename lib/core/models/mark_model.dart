import 'package:red_squirrel/utils/constants/classes.dart';

class MarkModel {
  final List<Mark>? marks;

  MarkModel({
    this.marks,
  });

  MarkModel copyWith({
    List<Mark>? marks,
  }) {
    return MarkModel(
        marks: marks ?? this.marks);
  }

  factory MarkModel.fromSnapsot(Map<String, dynamic> snapshot) {
    return MarkModel(
      marks: List<Mark>.from(
          snapshot['marks'].map((i) => Quiz.fromJson(i)).toList() ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        'marks': marks!.map((e) => e.toJson()).toList(),
      };
}

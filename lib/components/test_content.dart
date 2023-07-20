// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';

import 'package:red_squirrel/widgets/answer_button.dart';
import 'package:red_squirrel/widgets/question_label.dart';
import 'package:red_squirrel/widgets/boolean_button_compound.dart';

class TestContent extends StatefulWidget {
  final int count;
  final bool condition;
  final String question;
  final List<String> answers;
  final Color backgroundColor;
  final Color foregroundColor;

  const TestContent({
    super.key,
    required this.count,
    required this.condition,
    required this.question,
    required this.answers,
    this.backgroundColor = ThemeColors.secondary,
    this.foregroundColor = ThemeColors.progress,
  });

  @override
  State<TestContent> createState() => _TestContentState();
}

class _TestContentState extends State<TestContent> {
  int count = 0;
  bool condition = false;
  String question = '';
  List<String> answers = [];

  @override
  void initState() {
    super.initState();
    count = widget.count;
    condition = widget.condition;
    question = widget.question;
    answers = widget.answers;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      QuestionLabel(
        question: question,
      ),
      if (!condition)
        Column(
          children: [
            SizedBox(height: count == 4 ? 40 : 80),
            AnswerButton(
              answer: answers[0],
              isChecked: true,
              isTrue: false,
            ),
            SizedBox(height: count == 4 ? 0 : 20),
            AnswerButton(
              answer: answers[1],
              isChecked: true,
              isTrue: true,
            ),
            count == 4
                ? AnswerButton(
                    answer: answers[2],
                    isChecked: true,
                    isTrue: false,
                  )
                : Container(),
            count == 4
                ? AnswerButton(
                    answer: answers[3],
                  )
                : Container(),
          ],
        )
      else
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const Spacer(flex: 1),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                child: BooleanButtonCompound(
              isChecked: false,
              isTrue: true,
            )),
            // const Spacer(flex: 1),
            SizedBox(
              height: 40,
            ),
          ],
        )
    ]);
  }
}

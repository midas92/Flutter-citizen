// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';

import 'package:red_squirrel/widgets/answer_button.dart';
import 'package:red_squirrel/widgets/question_label.dart';
import 'package:red_squirrel/widgets/boolean_button_compound.dart';

class TestContent extends StatefulWidget {
  final int type;
  final String question;
  final List<String> answers;
  final List<bool> trueAnswers;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function onChange;
  final int possible_answers;
  final bool isSubmitted;

  const TestContent({
    super.key,
    required this.type,
    required this.question,
    required this.answers,
    required this.trueAnswers,
    required this.onChange,
    required this.possible_answers,
    required this.isSubmitted,
    this.backgroundColor = ThemeColors.secondary,
    this.foregroundColor = ThemeColors.progress,
  });

  @override
  State<TestContent> createState() => _TestContentState();
}

class _TestContentState extends State<TestContent> {
  List<bool> states = [false, false, false, false];
  bool conditionState = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.type != 4) {
        int selectedCount = 0;
        for (int i = 0; i < 4; i++) {
          if (states[i] == true) selectedCount++;
        }
        // Call setState() or markNeedsBuild() here
        if (selectedCount == widget.possible_answers) {
          widget.onChange(false);
        } else {
          widget.onChange(true);
        }
      } else {
        if (conditionState) {
          widget.onChange(false);
        }
      }
    });

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      QuestionLabel(
        question: widget.question,
      ),
      if (widget.type != 4)
        Column(
          children: [
            SizedBox(height: widget.type != 3 ? 40 : 80),
            AnswerButton(
              answer: widget.answers[0],
              isChecked: widget.isSubmitted,
              isTrue: widget.trueAnswers[0],
              onChange: (i, value) {
                setState(() {
                  states[i] = value;
                });
              },
              states: states,
              index: 0,
              state: false,
            ),
            SizedBox(height: widget.type != 3 ? 0 : 20),
            AnswerButton(
              answer: widget.answers[1],
              isChecked: widget.isSubmitted,
              isTrue: widget.trueAnswers[1],
              onChange: (i, value) {
                setState(() {
                  states[i] = value;
                });
              },
              states: states,
              index: 1,
              state: false,
            ),
            widget.type != 3
                ? AnswerButton(
                    answer: widget.answers[2],
                    isChecked: widget.isSubmitted,
                    isTrue: widget.trueAnswers[2],
                    onChange: (i, value) {
                      setState(() {
                        states[i] = value;
                      });
                    },
                    states: states,
                    index: 2,
                    state: false,
                  )
                : Container(),
            widget.type != 3
                ? AnswerButton(
                    answer: widget.answers[3],
                    isChecked: widget.isSubmitted,
                    isTrue: widget.trueAnswers[3],
                    onChange: (i, value) {
                      setState(() {
                        states[i] = value;
                      });
                    },
                    states: states,
                    index: 3,
                    state: false,
                  )
                : Container(),
          ],
        )
      else
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox(
                child: BooleanButtonCompound(
              isChecked: widget.isSubmitted,
              isTrue: true,
              onChange: () {
                setState(() {
                  conditionState = true;
                });
              },
            )),
          ],
        )
    ]);
  }
}

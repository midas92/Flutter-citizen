// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class AnswerButton extends StatefulWidget {
  final String answer;
  final bool isTrue;
  final bool isChecked;

  const AnswerButton({
    super.key,
    required this.answer,
    this.isTrue = true,
    this.isChecked = false,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  late String answer;
  bool status = false;

  @override
  void initState() {
    super.initState();
    answer = widget.answer;
  }

  void onClick() {
    setState(() {
      status = !status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ElevatedButton(
          onPressed: () {
            onClick();
            // Add your button logic here
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                  width: 2.0, // Set the desired border width here
                  color: !widget.isChecked
                      ? Colors.grey.shade300
                      : (widget.isTrue
                          ? ThemeColors.counterColor
                          : ThemeColors
                              .primary), // Set the desired border color here
                ),
              ),
              backgroundColor:
                  status == true ? ThemeColors.background : Colors.white,
              foregroundColor: ThemeColors.secondary,
              shadowColor: Colors.grey,
              elevation: 2.0,
              splashFactory: NoSplash.splashFactory),
          child: Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              Text(
                widget.answer,
                textAlign: TextAlign.center,
                softWrap: true,
                style: CustomTextStyle.LabelText(),
              ),
              const Spacer(
                flex: 1,
              )
            ],
          ),
        ));
  }
}

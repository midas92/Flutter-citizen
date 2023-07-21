// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class BooleanButtonCompound extends StatefulWidget {
  final bool isChecked;
  final bool isTrue;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function onChange;
  // final Function onPressed;

  const BooleanButtonCompound({
    super.key,
    // required this.onPressed,
    required this.isChecked,
    required this.isTrue,
    required this.onChange,
    this.backgroundColor = ThemeColors.label,
    this.foregroundColor = ThemeColors.label,
  });

  @override
  State<BooleanButtonCompound> createState() => _BooleanButtonCompoundState();
}

class _BooleanButtonCompoundState extends State<BooleanButtonCompound> {
  int status = -1;
  late bool isTrue;

  @override
  void initState() {
    super.initState();
    isTrue = widget.isTrue;
  }

  void onTrue() {
    setState(() {
      status = 1;
    });
  }

  void onFalse() {
    setState(() {
      status = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle trueButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: widget.backgroundColor,
      backgroundColor: status == 1 ? ThemeColors.secondary : ThemeColors.label,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      side: const BorderSide(
        color: ThemeColors.secondary,
        width: 2,
        style: BorderStyle.solid,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100), bottomLeft: Radius.circular(100))),
    );

    final ButtonStyle falseButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: widget.foregroundColor,
      backgroundColor: status == 0 ? ThemeColors.primary : ThemeColors.label,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      side: const BorderSide(
        color: ThemeColors.primary,
        width: 2,
        style: BorderStyle.solid,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100))),
    );
    return Row(children: [
      const Spacer(
        flex: 1,
      ),
      Transform(
          transform: Matrix4.skewX(-0.2),
          child: ElevatedButton(
              style: trueButtonStyle,
              onPressed: () {
                onTrue();
                widget.onChange();
              },
              child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(children: [
                    if (isTrue)
                      Image.asset(
                        Images.success,
                        width: 28,
                        height: 28,
                        color: widget.isChecked && isTrue
                            ? null
                            : Color.fromRGBO(255, 255, 255, 0),
                      ),
                    if (!isTrue)
                      Image.asset(
                        Images.fail,
                        width: 28,
                        height: 28,
                        color: widget.isChecked && !isTrue
                            ? null
                            : Color.fromRGBO(255, 255, 255, 0),
                      ),
                    Text(
                      'TRUE',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.SubText(
                          status == 1
                              ? ThemeColors.label
                              : ThemeColors.secondary,
                          20,
                          FontWeight.w900,
                          Fonts.primaryFont,
                          [],
                          4),
                    ),
                  ])))),
      Transform(
          transform: Matrix4(
            1,
            0,
            0,
            0,
            -0.2,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            -4.5,
            10,
            0,
            1,
          ),
          child: ElevatedButton(
              style: falseButtonStyle,
              onPressed: () {
                onFalse();
                widget.onChange();
              },
              child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: [
                      Text(
                        'FALSE',
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.SubText(
                            status == 0
                                ? ThemeColors.label
                                : ThemeColors.primary,
                            20,
                            FontWeight.w900,
                            Fonts.primaryFont,
                            [],
                            4),
                      ),
                      if (!isTrue)
                        Image.asset(
                          Images.success,
                          width: 28,
                          height: 28,
                          color: widget.isChecked && !isTrue
                              ? null
                              : Color.fromRGBO(255, 255, 255, 0),
                        ),
                      if (isTrue)
                        Image.asset(
                          Images.fail,
                          width: 28,
                          height: 28,
                          color: widget.isChecked && isTrue
                              ? null
                              : Color.fromRGBO(255, 255, 255, 0),
                        ),
                    ],
                  )))),
      const Spacer(
        flex: 1,
      ),
    ]);
  }
}

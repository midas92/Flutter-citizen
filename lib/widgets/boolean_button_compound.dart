// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class BooleanButtonCompound extends StatefulWidget {
  final bool isChecked;
  final bool isTrue;
  final Color backgroundColor;
  final Color foregroundColor;
  // final Function onPressed;

  const BooleanButtonCompound({
    super.key,
    // required this.onPressed,
    required this.isChecked,
    required this.isTrue,
    this.backgroundColor = ThemeColors.label,
    this.foregroundColor = ThemeColors.label,
  });

  @override
  State<BooleanButtonCompound> createState() => _BooleanButtonCompoundState();
}

class _BooleanButtonCompoundState extends State<BooleanButtonCompound> {
  int status = -1;
  late bool isTrue;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isTrue = widget.isTrue;
    isChecked = widget.isChecked;
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
    return Row(
        //margin: const EdgeInsets.symmetric(vertical: 20),
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     // Button on press action
          //   },
          //   child: Container(
          //       margin: EdgeInsets.all(0),
          //       color: ThemeColors.label,
          //       child: SvgPicture.asset(
          //         SvgIcons.true_outlined,
          //         width: 56,
          //         height: 56,
          //       )), // Replace with your actual image path
          //   //label: Text('TRUE'),
          // )

          const Spacer(
            flex: 1,
          ),
          Transform(
              transform: Matrix4.skewX(-0.2),
              child: ElevatedButton(
                  style: trueButtonStyle,
                  onPressed: () {
                    onTrue();
                  },
                  child: Container(
                      padding: isChecked
                          ? const EdgeInsets.fromLTRB(0, 12, 0, 12)
                          : const EdgeInsets.fromLTRB(15, 12, 5, 12),
                      child: Row(children: [
                        if (isChecked && isTrue)
                          Image.asset(
                            Images.success,
                            width: 28,
                            height: 28,
                          ),
                        if (isChecked && !isTrue)
                          Image.asset(
                            Images.fail,
                            width: 28,
                            height: 28,
                          ),
                        const SizedBox(
                          width: 5,
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
                  },
                  child: Container(
                      padding: isChecked
                          ? const EdgeInsets.fromLTRB(0, 12, 0, 12)
                          : const EdgeInsets.fromLTRB(5, 12, 12, 12),
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
                          const SizedBox(
                            width: 5,
                          ),
                          if (isChecked && !isTrue)
                            Image.asset(
                              Images.success,
                              width: 28,
                              height: 28,
                            ),
                          if (isChecked && isTrue)
                            Image.asset(
                              Images.fail,
                              width: 28,
                              height: 28,
                            ),
                        ],
                      )))),
          const Spacer(
            flex: 1,
          ),
        ]);
  }
}

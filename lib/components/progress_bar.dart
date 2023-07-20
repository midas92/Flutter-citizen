// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class ProgressBar extends StatefulWidget {
  final int count;
  final Color backgroundColor;
  final Color foregroundColor;

  const ProgressBar({
    super.key,
    required this.count,
    this.backgroundColor = ThemeColors.secondary,
    this.foregroundColor = ThemeColors.progress,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late int count;
  int step = 1;

  @override
  void initState() {
    super.initState();
    count = widget.count;
  }

  void next() {
    setState(() {
      if (step < count) step += 1;
    });
  }

  void previous() {
    setState(() {
      if (step > 1) step -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: IconButton(
                // padding: const EdgeInsets.only(left: 4),
                icon: SvgPicture.asset(
                  step == 1 ? SvgIcons.previous_disabled : SvgIcons.previous,
                  width: 24,
                  height: 24,
                ),

                onPressed: () {
                  previous();
                  // Handle previous button press
                },
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              '$step / $count',
              style: CustomTextStyle.DescText(),
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              child: IconButton(
                // padding: const EdgeInsets.all(0.0),
                color: Colors.red,
                icon: SvgPicture.asset(
                  step == count ? SvgIcons.next_disabled : SvgIcons.next,
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  next();
                  // Handle next button press
                },
              ),
            ),
          ],
        ),
        GFProgressBar(
          percentage: step / count * 1.0,
          lineHeight: 8.5,
          backgroundColor: widget.foregroundColor,
          progressBarColor: widget.backgroundColor,
          animation: true,
          animationDuration: 160,
          animateFromLastPercentage: true,
        ),
      ],
    );
  }
}

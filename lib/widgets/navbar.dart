// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/strings.dart';

import 'dart:math';

import 'package:red_squirrel/views/home/home_page.dart';
import 'package:red_squirrel/widgets/dialog.dart';

class NavBar extends StatefulWidget {
  final Function backAction;
  final Function refreshAction;
  final Color backgroundColor;
  final Color foregroundColor;

  const NavBar({
    super.key,
    required this.backAction,
    required this.refreshAction,
    this.backgroundColor = ThemeColors.secondary,
    this.foregroundColor = ThemeColors.progress,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    super.initState();
  }

  void cancelAction() {
    Navigator.of(context).pop();
  }

  void homeAction() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 43,
        color: ThemeColors.secondary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: IconButton(
                icon: SvgPicture.asset(
                  SvgIcons.previousNav,
                ),
                onPressed: () {
                  widget.backAction();
                },
              ),
            ),
            SizedBox(
              width: 42,
              height: 42,
              child: Stack(
                children: [
                  Transform.rotate(
                    angle: 45 * pi / 180, // rotate 45 degrees (in radians)
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeColors.secondary,
                        border: Border.all(
                          color: ThemeColors.secondary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  Positioned.fromRelativeRect(
                    rect: const RelativeRect.fromLTRB(0, 0, 0, 0),
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      icon: SvgPicture.asset(
                        SvgIcons.diamond,
                        width: 38,
                        height: 38,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                                title: Strings.homeTitle,
                                description: Strings.homeDescription,
                                submitAction: homeAction,
                                cancelAction: cancelAction);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: IconButton(
                icon: SvgPicture.asset(
                  SvgIcons.refresh,
                ),
                onPressed: () {
                  widget.refreshAction();
                },
              ),
            ),
          ],
        ));
  }
}

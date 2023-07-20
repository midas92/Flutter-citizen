// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pressable/pressable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

class BuyBooksSection extends StatelessWidget {
  const BuyBooksSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Pressable.opacity(
            onPressed: () async {
              const url = 'https://www.lifeintheuk.net/books';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                // ignore: avoid_print
                print("Could not launch $url");
              }
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0, // soften the shadow
                        spreadRadius: 1.0,
                        blurStyle: BlurStyle.outer),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: ThemeColors.gradient3,
                  ),
                  child: Stack(children: [
                    Positioned(
                        right: 0,
                        bottom: 0,
                        height: 60,
                        child: Image.asset(
                          SvgIcons.books,
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Text(
                          Strings.homeBuyBooks,
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.SectionTitle(
                              ThemeColors.secondary,
                              24,
                              FontWeight.w700,
                              Fonts.primaryFont, [
                            const Shadow(
                                color: Colors.white,
                                offset: Offset(3, 0),
                                blurRadius: 0),
                            const Shadow(
                                color: Colors.white,
                                offset: Offset(-3, 0),
                                blurRadius: 0),
                            const Shadow(
                                color: Colors.white,
                                offset: Offset(0, 2),
                                blurRadius: 0),
                            const Shadow(
                                color: Colors.white,
                                offset: Offset(0, -2),
                                blurRadius: 0)
                          ]),
                        )),
                  ]),
                ))));
  }
}

// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/views/home/widgets/buy_books_section.dart';
import 'package:red_squirrel/views/home/widgets/chapter_test_section.dart';
import 'package:red_squirrel/views/home/widgets/full_test_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const HomePage());

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(children: [
          Expanded(
            flex: 230,
            child: Stack(children: [
              Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.logo,
                        fit: BoxFit.fill,
                        height: 60,
                      ),
                      const SizedBox(width: 20),
                      Image.asset(
                        Images.title,
                        fit: BoxFit.fill,
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -1,
                left: 0,
                right: 0,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      color: Theme.of(context).colorScheme.background),
                ),
              ),
            ]),
          ),
          Expanded(
              flex: 700,
              child: Stack(
                children: [
                  Positioned(
                      bottom: -50,
                      right: 10,
                      width: 280,
                      child: Image.asset(
                        Images.bridge,
                        fit: BoxFit.fill,
                      )),
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: const [
                        FullTestSection(),
                        SizedBox(height: 16),
                        Expanded(
                            flex: 20,
                            child: Row(
                              children: [
                                ChapterTestSection(),
                                SizedBox(width: 16),
                                BuyBooksSection()
                              ],
                            )),
                        SizedBox(height: 200),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 55,
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ]),
      ],
    ));
  }
}

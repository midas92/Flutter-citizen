// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';
import 'package:red_squirrel/views/full_test/result_page.dart';

import 'package:red_squirrel/widgets/timer.dart';
import 'package:red_squirrel/widgets/submit_button.dart';
import 'package:red_squirrel/widgets/navbar.dart';

import 'package:red_squirrel/components/progress_bar.dart';
import 'package:red_squirrel/components/test_content.dart';

class FullTestPage extends StatefulWidget {
  const FullTestPage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: FullTestPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const FullTestPage());

  @override
  _FullTestPage createState() => _FullTestPage();
}

class _FullTestPage extends State<FullTestPage> {
  int index = 1;
  int count = 4;
  int selectedCount = 0;
  bool disabled = true;
  Timer? _timer;
  // bool isSubmitted = false;
  // bool showFeedback = false;

  List<bool> isSubmitted = [false, false, false, false, false];
  List<bool> showFeedback = [false, false, false, false, false];

  List<int> PossibleAnswers = [0, 2, 1, 1, 1];
  List<String> Questions = [
    '',
    'Who was the first person to sail single-handed around the world?',
    'Who was the first person to sail single-handed around the world?Who was the first person to sail single-handed around the world?',
    'Who was the first person to sail single-handed around the world?Who was the first person to sail single-handed around the world?Who was the first person to sail single-handed around the world?',
    'Who was the first person to sail single-handed around the world?'
  ];
  List<List<String>> Answers = [
    [],
    [
      'Sr. Francis Drake',
      'Sr. Francis Walsingham',
      'Sr. Francis Chichester',
      'Sr. Robin Knox-Johnston'
    ],
    [
      'Sr. Francis Drake',
      'Sr. Francis Walsingham',
      'Sr. Francis Chichester',
      'Sr. Robin Knox-Johnston'
    ],
    [
      'Sr. Francis Drake',
      'Sr. Francis Walsingham',
    ],
    []
  ];
  List<List<bool>> trueAnswers = [
    [],
    [
      true,
      false,
      true,
      false,
    ],
    [
      false,
      true,
      false,
      false,
    ],
    [
      true,
      false,
    ],
    [true, false]
  ];

  void next() {
    setState(() {
      disabled = true;
      if (index < count) index += 1;
    });
  }

  void previous() {
    setState(() {
      disabled = true;
      if (index > 1) index -= 1;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    // Start the timer with a duration of 2 seconds
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        showFeedback[index] = false;
      });
    });
  }

  void _cancelTimer() {
    // Cancel the timer if it is currently running
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(children: [
          //////////// Header ///////////////
          Container(
            padding: const EdgeInsets.only(bottom: 15, top: 49),
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                Strings.fullTestCaption.toUpperCase(),
                style: CustomTextStyle.SectionTitle(
                  ThemeColors.label,
                  30,
                  FontWeight.w900,
                  Fonts.primaryFont,
                  [],
                  2,
                ),
              ),
            ),
          ),

          /////////////Content////////////
          Expanded(
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                clipBehavior: Clip.none,
                decoration: const BoxDecoration(
                  color: ThemeColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Stack(children: [
                  // if (showFeedback)
                  //   Text(
                  //       'Since 1999, hereditary peers have lost the automatic right to attend the House of Lords. '),
                  Positioned(
                      bottom: -46,
                      right: -12,
                      width: 280,
                      child: Image.asset(
                        Images.bridge,
                        fit: BoxFit.scaleDown,
                      )),
                  Column(
                    children: [
                      ///////////////////////////Bridge/////////////////////////////////
                      Row(
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          SizedBox(
                            child: CountTimer(
                              timeDuration: 0,
                            ),
                          ),
                        ],
                      ),
                      ///////////////////////////ProgressBar//////////////////////////////
                      ProgressBar(
                        count: count,
                        step: index,
                        caption: '$index / $count',
                        next: () {
                          setState(() {
                            if (index < count) index += 1;
                          });
                        },
                        previous: () {
                          setState(() {
                            if (index > 1) index -= 1;
                          });
                        },
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      ///////////////////////////Content//////////////////////////////
                      Expanded(
                          child: SingleChildScrollView(
                        child: TestContent(
                          question: Questions[index],
                          answers: Answers[index],
                          trueAnswers: trueAnswers[index],
                          type: index,
                          possible_answers: PossibleAnswers[index],
                          isSubmitted: isSubmitted[index],
                          onChange: (state) {
                            setState(() {
                              disabled = state;
                            });
                          },
                        ),
                      )),
                      ///////////////////////////Submit//////////////////////////////
                      Row(
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          SizedBox(
                              child: SubmitButton(
                                  disabled: disabled,
                                  text: isSubmitted[index]
                                      ? Strings.feedbackButton
                                      : Strings.submitButton,
                                  onSubmit: () {
                                    setState(() {
                                      //isSubmitted[index] = true;
                                      next();
                                    });
                                  },
                                  onFeedback: () {
                                    setState(() {
                                      showFeedback[index] = true;
                                      _startTimer();
                                    });
                                  })),
                          const Spacer(
                            flex: 1,
                          )
                        ],
                      )
                    ],
                  ),
                  if (showFeedback[index])
                    Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              width: MediaQuery.of(context).size.width,
                              height: 90,
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                gradient: showFeedback[index]
                                    ? ThemeColors.gradient4
                                    : ThemeColors.gradient5,
                              ),
                              child: Center(
                                  child: Text(
                                showFeedback[index]
                                    ? 'Since 1999, hereditary peers have lost the automatic right to attend the House of Lords.'
                                    : '',
                                style:
                                    CustomTextStyle.SpanText(ThemeColors.label),
                                textAlign: TextAlign.left,
                                softWrap: true,
                              ))),
                        )
                      ],
                    ),
                ]),
              ),
            ]),
          ),

          ///////////  NavBar ///////////////
          NavBar(),
        ]));
  }
}

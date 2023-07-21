// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

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
  bool isSubmitted = false;
  bool showFeedback = false;

  void next() {
    setState(() {
      if (index < count) index += 1;
      isSubmitted = false;
      disabled = true;
    });
  }

  void previous() {
    setState(() {
      if (index > 1) index -= 1;
      isSubmitted = false;
      disabled = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  if (showFeedback)
                    Text(
                        'Since 1999, hereditary peers have lost the automatic right to attend the House of Lords. '),
                  // Positioned(
                  //   bottom: -50,
                  //   child: Container(
                  //       width: double.infinity,
                  //       height: 220,
                  //       decoration: BoxDecoration(
                  //           gradient: LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: [
                  //           Color(0xff424242),
                  //           Color(0xff191919),
                  //           Colors.black
                  //         ],
                  //       ))),
                  // ),
                  Positioned(
                      bottom: -46,
                      right: -12,
                      width: 280,
                      child: Image.asset(
                        Images.bridge,
                        fit: BoxFit.scaleDown,
                      )),
                  Column(children: [
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
                      // child: TestContent(
                      //   question:
                      //       'Who was the first person to sail single-handed around the world?',
                      //   answers: [
                      //     'Sr. Francis Drake',
                      //     'Sr. Francis Walsingham',
                      //     'Sr. Francis Chichester',
                      //     'Sr. Robin Knox-Johnston'
                      //   ],
                      //   type: 1,
                      //   possible_answers: 1,
                      //   isSubmitted: isSubmitted,
                      //   onChange: (state) {
                      //     setState(() {
                      //       disabled = state;
                      //     });
                      //   },
                      // ),
                      child: TestContent(
                        question: Questions[index],
                        answers: Answers[index],
                        type: index,
                        possible_answers: PossibleAnswers[index],
                        isSubmitted: isSubmitted,
                        onChange: (state) {
                          setState(() {
                            disabled = state;
                          });
                        },
                      ),

                      // child: TestContent(
                      //   question:
                      //       'Who was the first person to sail single-handed around the world?Who was the first person to sail single-handed around the world?Who was the first person to sail single-handed around the world?',
                      //   answers: [
                      //     'Sr. Francis Drake',
                      //     'Sr. Francis Walsingham',
                      //   ],
                      //   type: 3,
                      //   possible_answers: 1,
                      //   isSubmitted: isSubmitted,
                      //   onChange: (state) {
                      //     setState(() {
                      //       disabled = state;
                      //     });
                      //   },
                      // ),

                      // child: TestContent(
                      //     question:
                      //         'Who was the first person to sail single-handed around the world?',
                      //     answers: [],
                      //     type: 4,
                      //     possible_answers: 1,
                      //     isSubmitted: isSubmitted,
                      //     onChange: (state) {
                      //       setState(() {
                      //         disabled = state;
                      //       });
                      //     }),
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
                                text: isSubmitted
                                    ? Strings.feedbackButton
                                    : Strings.submitButton,
                                onSubmit: () {
                                  setState(() {
                                    isSubmitted = true;
                                  });
                                },
                                onFeedback: () {
                                  setState(() {
                                    showFeedback = true;
                                  });
                                })),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    )
                  ]),
                ]),
              ),
            ]),
          ),

          ///////////  NavBar ///////////////
          NavBar(),
        ]));
  }
}

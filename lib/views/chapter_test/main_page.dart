import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressable/pressable.dart';
import 'package:red_squirrel/core/blocs/mark/mark_bloc.dart';
import 'package:red_squirrel/core/blocs/quiz/quiz_bloc.dart';
import 'package:red_squirrel/core/models/mark_model.dart';
import 'package:red_squirrel/services/mark.dart';
import 'package:red_squirrel/utils/constants/classes.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
// import 'package:red_squirrel/widgets/navbar.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_squirrel/utils/functions/cal_percentage.dart';
import 'package:red_squirrel/views/chapter_test/test_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: MainPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const MainPage());

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  // Future<List<String>>
  void fetchData() async {
    // Simulated asynchronous fetch of data
    List<dynamic> marks = await getMarks();
  }

  @override
  Widget build(BuildContext context) {
    _testByChapter(int chapterNumber, String chapter, String status,
        int percent, int score, int total) {
      return Pressable.opacity(
          onPressed: () async {
            List<int> chapters = [];
            int countQuestions = 24;
            switch (chapterNumber) {
              case 2:
                chapters = [2, 3];
                countQuestions = 12;
                break;
              case 4:
                chapters = [4];
                countQuestions = 24;
                break;
              case 5:
                chapters = [5];
                countQuestions = 24;
                break;
              case 6:
                chapters = [6];
                countQuestions = 24;
                break;
            }
            context
                .read<QuizBloc>()
                .add(QuizLoadRequested(chapters, countQuestions));
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChapterTestPage(
                        chapter: chapterNumber,
                        count: countQuestions,
                      )),
            );
          },
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1),
                  // borderRadius: BorderRadius.circular(12),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: const [
                    BoxShadow(
                        color: ThemeColors.progressBar,
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: Offset(0, 2)),
                  ],
                  border: Border.all(width: 1.0, color: Colors.grey),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(status,
                            style: status.toUpperCase() == "PASSED"
                                ? CustomTextStyle.LabelText(ThemeColors.success)
                                : CustomTextStyle.LabelText(ThemeColors.failed)
                            // ,
                            ),
                        SizedBox(height: 10),
                        Center(
                          child: SvgPicture.asset(
                            SvgIcons.line3,
                            width: 130,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('$percent%',
                                style: status.toUpperCase() == "PASSED"
                                    ? CustomTextStyle.LabelText(
                                        ThemeColors.success)
                                    : CustomTextStyle.LabelText(
                                        ThemeColors.failed)),
                            SizedBox(
                              width: 40,
                            ),
                            Text('$score / $total',
                                style: status.toUpperCase() == "PASSED"
                                    ? CustomTextStyle.LabelText(
                                        ThemeColors.success)
                                    : CustomTextStyle.LabelText(
                                        ThemeColors.failed))
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          chapter == "2&3" ? "Chapters " : Strings.chapter,
                          // Strings.chapter,
                          style:
                              CustomTextStyle.DescText(ThemeColors.secondary),
                        ),
                        Text(
                          chapter,
                          style: CustomTextStyle.SubText(ThemeColors.secondary),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          ));
    }

    return BlocBuilder<MarkBloc, MarkState>(
      builder: (context, state) {
        if (state.status == MarkStatus.loading) {
          return Container();
        } else if (state.status == MarkStatus.success) {
          MarkModel mark = context.read<MarkBloc>().state.mark;
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              body: Column(children: [
                //////////// Header ///////////////
                Container(
                  padding: const EdgeInsets.only(bottom: 15, top: 49),
                  color: Theme.of(context).colorScheme.primary,
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(Strings.testByChapter.toUpperCase(),
                        style: CustomTextStyle.SectionTitle(ThemeColors.label)),
                  ),
                ),

                /////////////Content////////////
                Expanded(
                  child: Stack(children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      clipBehavior: Clip.none,
                      decoration: const BoxDecoration(
                        color: ThemeColors.background,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                      ),
                      child: Stack(children: [
                        Positioned(
                            bottom: -46,
                            right: -12,
                            width: 280,
                            child: Image.asset(
                              Images.bridge,
                              fit: BoxFit.scaleDown,
                            )),
                        Column(children: [
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(height: 40),
                                  _testByChapter(
                                      2,
                                      Strings.two,
                                      mark.marks![0].total != 0
                                          ? calPercentage(
                                                      mark.marks![0].correct,
                                                      mark.marks![0].total) >
                                                  75
                                              ? "Passed"
                                              : "Failed"
                                          : "",
                                      mark.marks![0].total != 0
                                          ? calPercentage(
                                              mark.marks![0].correct,
                                              mark.marks![0].total)
                                          : 0,
                                      mark.marks![0].correct,
                                      mark.marks![0].total),
                                  _testByChapter(
                                      4,
                                      Strings.four,
                                      mark.marks![1].total != 0
                                          ? calPercentage(
                                                      mark.marks![1].correct,
                                                      mark.marks![1].total) >
                                                  75
                                              ? "Passed"
                                              : "Failed"
                                          : "",
                                      mark.marks![1].total != 0
                                          ? calPercentage(
                                              mark.marks![1].correct,
                                              mark.marks![1].total)
                                          : 0,
                                      mark.marks![1].correct,
                                      mark.marks![1].total),
                                  _testByChapter(
                                      5,
                                      Strings.five,
                                      mark.marks![2].total != 0
                                          ? calPercentage(
                                                      mark.marks![2].correct,
                                                      mark.marks![2].total) >
                                                  75
                                              ? "Passed"
                                              : "Failed"
                                          : "",
                                      mark.marks![2].total != 0
                                          ? calPercentage(
                                              mark.marks![2].correct,
                                              mark.marks![2].total)
                                          : 0,
                                      mark.marks![2].correct,
                                      mark.marks![2].total),
                                  _testByChapter(
                                      6,
                                      Strings.six,
                                      mark.marks![3].total != 0
                                          ? calPercentage(
                                                      mark.marks![3].correct,
                                                      mark.marks![3].total) >
                                                  75
                                              ? "Passed"
                                              : "Failed"
                                          : "",
                                      mark.marks![3].total != 0
                                          ? calPercentage(
                                              mark.marks![3].correct,
                                              mark.marks![3].total)
                                          : 0,
                                      mark.marks![3].correct,
                                      mark.marks![3].total),
                                ]),
                          )),
                        ]),
                      ]),
                    ),
                  ]),
                ),
                ///////////  NavBar ///////////////
                // NavBar(),
              ]));
        } else if (state.status == MarkStatus.empty) {
          return Text('Mark is empty!');
        } else if (state.status == MarkStatus.failure) {
          return Text('Failed to load Mark.');
        } else {
          return Container();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/level_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';

import '../../config/demension_const.dart';
import '../../features/choose_exam/getx/grade_controller.dart';

class ChooseExamConditionScreen extends StatelessWidget {
  const ChooseExamConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final levelController = Get.put(LevelController());
    final gradeController = Get.put(GradeController());
    final chapterController = Get.put(ChapterController());
    final quizmatrixController = Get.put(QuizMatrixController());
    final examController = Get.put(ExamController());
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Obx(
            () => levelController.isLoading.value ||
                    gradeController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(251, 252, 253, 1),
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kMinPadding, vertical: kMinPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: "Chọn ",
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: "đề thi",
                                      style: TextStyle(
                                          fontSize: 32,
                                          color: ColorPalette.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]),
                                ),
                                const SizedBox(
                                  height: kDefaultPadding,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showLevelDialog(context, levelController,
                                        gradeController, chapterController);
                                  },
                                  child: Container(
                                    // height:
                                    //     (SizeConfig.screenWidth! - kDefaultPadding * 2) / 2 -
                                    //         kDefaultPadding / 2,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          251, 252, 253, 1),
                                    ),
                                    child: Center(
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kMinPadding / 2),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/level_icon.png',
                                                  height: 45,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: kMinPadding / 3,
                                          ),
                                          Expanded(
                                            child: Obx(
                                              () => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Cấp học',
                                                    style: TextStyle(
                                                        color: ColorPalette
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    levelController.chosenLevel
                                                            .value?.name ??
                                                        'Chọn cấp',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kMinPadding / 2,
                                      horizontal: kMinPadding / 3),
                                  child: Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: ColorPalette.greyColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showGradeDialog(context, gradeController,
                                        chapterController, levelController);
                                  },
                                  child: Container(
                                    // height:
                                    //     (SizeConfig.screenWidth! - kDefaultPadding * 2) / 2 -
                                    //         kDefaultPadding / 2,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          251, 252, 253, 1),
                                    ),
                                    child: Center(
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kMinPadding / 2),
                                            child: Image.asset(
                                              'assets/images/grade_icon.png',
                                              height: 45,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: kMinPadding / 3,
                                          ),
                                          Expanded(
                                            child: Obx(
                                              () => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  levelController.chosenLevel
                                                              .value!.id ==
                                                          4
                                                      ? const Text(
                                                          'Môn',
                                                          style: TextStyle(
                                                              color: ColorPalette
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      : const Text(
                                                          'Lớp',
                                                          style: TextStyle(
                                                              color: ColorPalette
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    gradeController.chosenGrade
                                                            .value?.name ??
                                                        'Chọn lớp',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => chapterController
                                          .isHasMultiMathType.value
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: kMinPadding / 3,
                                              vertical: kMinPadding / 3),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: ColorPalette
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => chapterController
                                                        .fetchChapterByMathType(
                                                            1,
                                                            gradeController
                                                                .chosenGrade
                                                                .value!
                                                                .id),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius
                                                            .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    defaultBorderRadius),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    defaultBorderRadius)),
                                                        color: chapterController
                                                                    .chosenMathType
                                                                    .value ==
                                                                1
                                                            ? ColorPalette
                                                                .primaryColor
                                                            : Colors.white,
                                                      ),
                                                      height: 30,
                                                      child: Center(
                                                          child: Text(
                                                        'Đại số',
                                                        style: chapterController
                                                                    .chosenMathType
                                                                    .value ==
                                                                1
                                                            ? const TextStyle(
                                                                color: Colors
                                                                    .white)
                                                            : null,
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => chapterController
                                                        .fetchChapterByMathType(
                                                            2,
                                                            gradeController
                                                                .chosenGrade
                                                                .value!
                                                                .id),
                                                    child: Container(
                                                      color: chapterController
                                                                  .chosenMathType
                                                                  .value ==
                                                              2
                                                          ? ColorPalette
                                                              .primaryColor
                                                          : Colors.white,
                                                      height: 30,
                                                      child: Center(
                                                          child: Text(
                                                        'Hình học',
                                                        style: chapterController
                                                                    .chosenMathType
                                                                    .value ==
                                                                2
                                                            ? const TextStyle(
                                                                color: Colors
                                                                    .white)
                                                            : null,
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => chapterController
                                                        .fetchChapterByMathType(
                                                            7,
                                                            gradeController
                                                                .chosenGrade
                                                                .value!
                                                                .id),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius
                                                            .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    defaultBorderRadius),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    defaultBorderRadius)),
                                                        color: chapterController
                                                                    .chosenMathType
                                                                    .value ==
                                                                7
                                                            ? ColorPalette
                                                                .primaryColor
                                                            : Colors.white,
                                                      ),
                                                      height: 30,
                                                      child: Center(
                                                          child: Text(
                                                        'Tổng hợp',
                                                        style: chapterController
                                                                    .chosenMathType
                                                                    .value ==
                                                                7
                                                            ? const TextStyle(
                                                                color: Colors
                                                                    .white)
                                                            : null,
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kMinPadding / 2,
                                      horizontal: kMinPadding / 3),
                                  child: Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: ColorPalette.greyColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showChapterDialog(
                                        context,
                                        chapterController,
                                        quizmatrixController);
                                  },
                                  child: Container(
                                    // height:
                                    //     (SizeConfig.screenWidth! - kDefaultPadding * 2) / 2 -
                                    //         kDefaultPadding / 2,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          251, 252, 253, 1),
                                    ),
                                    child: Center(
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kMinPadding / 2),
                                            child: Image.asset(
                                              'assets/images/chapter_icon.png',
                                              height: 45,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: kMinPadding / 3,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Chương',
                                                  style: TextStyle(
                                                      color: ColorPalette
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Obx(
                                                  () => chapterController
                                                          .isLoading.value
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : chapterController
                                                                  .chosenChapter
                                                                  .value
                                                                  ?.name ==
                                                              null
                                                          ? const Text(
                                                              'Chọn chương',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )
                                                          : Text.rich(
                                                              TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text: chapterController
                                                                            .chosenChapter
                                                                            .value
                                                                            ?.name),
                                                                    TextSpan(
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w400),
                                                                        text: quizmatrixController.quizMatrixList.firstWhereOrNull((element) => element.chapterId == chapterController.chosenChapter.value!.id) !=
                                                                                null
                                                                            ? ': ${quizmatrixController.quizMatrixList.firstWhereOrNull((element) => element.chapterId == chapterController.chosenChapter.value!.id)!.name}'
                                                                            : ""),
                                                                  ]),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Obx(
                                  () => ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: chapterController
                                                  .chosenChapter.value !=
                                              null
                                          ? WidgetStateProperty.all<Color>(
                                              ColorPalette.primaryColor)
                                          : WidgetStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                      255, 209, 208, 208)
                                                  .withOpacity(0.5)),
                                    ),
                                    onPressed: () async {
                                      if (chapterController
                                              .chosenChapter.value ==
                                          null) {
                                      } else {
                                        await quizmatrixController
                                            .fetchQuizMatricesByChapterId(
                                                chapterController
                                                    .chosenChapter.value!.id);
                                        await examController.fetchExams();
                                        await examController
                                            .fetchExamByQuizMatrixId(
                                                quizmatrixController
                                                    .chosenQuizMatrix
                                                    .value!
                                                    .id);
                                        examController.tempNumOfQuiz.value =
                                            quizmatrixController
                                                .chosenQuizMatrix
                                                .value!
                                                .numOfQuiz!;
                                        examController.tempDuration.value =
                                            quizmatrixController
                                                .chosenQuizMatrix
                                                .value!
                                                .defaultDuration!;
                                        await examController.fetchRanking(
                                            chapterController
                                                .chosenChapter.value!.id);
                                        Get.toNamed(Routes.examStartScreen);
                                      }
                                    },
                                    child: quizmatrixController
                                                .isLoading.value ||
                                            examController.isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text('Tiếp tục'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _showLevelDialog(BuildContext context, LevelController levelController,
      GradeController gradeController, ChapterController chapterController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'cấp học',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: levelController.levelList
                  .map((level) => ListTile(
                      title: Text(level.name),
                      onTap: () {
                        levelController.handleOnChangedLevel(
                            level, gradeController, chapterController);
                        Get.back();
                      }))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _showGradeDialog(BuildContext context, GradeController gradeController,
      ChapterController chapterController, LevelController levelController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chọn ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Obx(
                () => levelController.chosenLevel.value!.id == 4
                    ? const Text(
                        'môn',
                        style: TextStyle(
                            color: ColorPalette.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      )
                    : const Text(
                        'lớp',
                        style: TextStyle(
                            color: ColorPalette.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: gradeController.searchedGradeList
                  .map((grade) => ListTile(
                      title: Text(grade.name),
                      onTap: () {
                        gradeController.handleOnChangedGrade(
                            grade, chapterController);
                        Get.back();
                      }))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _showChapterDialog(
      BuildContext context,
      ChapterController chapterController,
      QuizMatrixController quizMatrixController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'chương',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: chapterController.searchedChapterList.map((chapter) {
                var quizMatrixName = quizMatrixController.quizMatrixList
                            .firstWhereOrNull(
                                (element) => element.chapterId == chapter.id) !=
                        null
                    ? quizMatrixController.quizMatrixList
                        .firstWhereOrNull(
                            (element) => element.chapterId == chapter.id)!
                        .name!
                    : '';
                return ListTile(
                    title: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '${chapter.name}: ',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: quizMatrixName,
                      ),
                    ])),
                    onTap: () => {
                          chapterController.chosenChapter.value = chapter,
                          Get.back()
                        });
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

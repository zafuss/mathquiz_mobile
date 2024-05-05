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
                        const Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "Chọn ",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: "đề thi",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: ColorPalette.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 2,
                        ),
                        const Text('Cấp học'),
                        const SizedBox(
                          height: 10,
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
                              color: const Color.fromRGBO(251, 252, 253, 1),
                            ),
                            child: Center(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kMinPadding / 2),
                                    child: Image.asset(
                                      'assets/images/level_icon.png',
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => Text(
                                        textAlign: TextAlign.center,
                                        levelController
                                                .chosenLevel.value?.name ??
                                            'Chọn cấp',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kMinPadding,
                        ),
                        Obx(() => levelController.chosenLevel.value!.id == 4
                            ? const Text('Môn')
                            : const Text('Lớp')),
                        const SizedBox(
                          height: 10,
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
                              color: const Color.fromRGBO(251, 252, 253, 1),
                            ),
                            child: Center(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kMinPadding / 2),
                                    child: Image.asset(
                                      'assets/images/grade_icon.png',
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => Text(
                                        textAlign: TextAlign.center,
                                        gradeController
                                                .chosenGrade.value?.name ??
                                            'Chọn lớp',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => chapterController.isHasMultiMathType.value
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => chapterController
                                            .fetchChapterByMathType(
                                                1,
                                                gradeController
                                                    .chosenGrade.value!.id),
                                        child: Container(
                                          color: chapterController
                                                      .chosenMathType.value ==
                                                  1
                                              ? ColorPalette.primaryColor
                                              : Colors.white,
                                          height: 30,
                                          child: Center(
                                              child: Text(
                                            'Đại số',
                                            style: chapterController
                                                        .chosenMathType.value ==
                                                    1
                                                ? const TextStyle(
                                                    color: Colors.white)
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
                                                    .chosenGrade.value!.id),
                                        child: Container(
                                          color: chapterController
                                                      .chosenMathType.value ==
                                                  2
                                              ? ColorPalette.primaryColor
                                              : Colors.white,
                                          height: 30,
                                          child: Center(
                                              child: Text(
                                            'Hình học',
                                            style: chapterController
                                                        .chosenMathType.value ==
                                                    2
                                                ? const TextStyle(
                                                    color: Colors.white)
                                                : null,
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ),
                        const SizedBox(
                          height: kMinPadding,
                        ),
                        const Text('Chương'),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showChapterDialog(context, chapterController);
                          },
                          child: Container(
                            // height:
                            //     (SizeConfig.screenWidth! - kDefaultPadding * 2) / 2 -
                            //         kDefaultPadding / 2,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(251, 252, 253, 1),
                            ),
                            child: Center(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kMinPadding / 2),
                                    child: Image.asset(
                                      'assets/images/chapter_icon.png',
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => chapterController.isLoading.value
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Text(
                                              textAlign: TextAlign.center,
                                              chapterController.chosenChapter
                                                      .value?.name ??
                                                  'Chọn chương',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 1.5 + 10,
                        ),
                        Obx(
                          () => ElevatedButton(
                            onPressed: () async {
                              await quizmatrixController
                                  .fetchQuizMatricesByChapterId(
                                      chapterController
                                          .chosenChapter.value!.id);
                              await examController.fetchExams();
                              await examController.fetchExamByQuizMatrixId(
                                  quizmatrixController
                                      .chosenQuizMatrix.value!.id);
                              Get.toNamed(Routes.examStartScreen);
                            },
                            child: quizmatrixController.isLoading.value ||
                                    examController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text('Tiếp tục'),
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
          title: const Text('Chọn cấp học'),
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
          title: Obx(() => levelController.chosenLevel.value!.id == 4
              ? const Text('Chọn môn')
              : const Text('Chọn lớp')),
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
      BuildContext context, ChapterController chapterController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn chương'),
          content: SingleChildScrollView(
            child: ListBody(
              children: chapterController.searchedChapterList
                  .map((chapter) => ListTile(
                      title: Text(chapter.name),
                      onTap: () => {
                            chapterController.chosenChapter.value = chapter,
                            Get.back()
                          }))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/grade_controller.dart';
import 'package:mathquiz_mobile/features/home/getx/home_controller.dart';
import 'package:mathquiz_mobile/helpers/score_formatter.dart';

class ExamHistoryScreen extends StatelessWidget {
  final int itemsPerPage = 10;

  const ExamHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final homeController = Get.put(HomeController());
    final examController = Get.put(ExamController());
    final chapterController = Get.put(ChapterController());
    final gradeController = Get.put(GradeController());
    final currentPage = 0.obs;

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
          Obx(() {
            return homeController.isLoading.value ||
                    examController.isLoading.value ||
                    chapterController.isLoading.value ||
                    gradeController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lịch sử',
                                style: TextStyle(
                                    color: ColorPalette.primaryColor,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'làm bài',
                                style: TextStyle(
                                    height: 1,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: kMinPadding / 2,
                              )
                            ],
                          ),
                          Expanded(
                            child: Obx(() {
                              final startIndex =
                                  currentPage.value * itemsPerPage;
                              final endIndex = (startIndex + itemsPerPage) >
                                      homeController.recentResults.length
                                  ? homeController.recentResults.length
                                  : startIndex + itemsPerPage;
                              final itemsToDisplay = homeController
                                  .recentResults
                                  .sublist(startIndex, endIndex);

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: itemsToDisplay.length,
                                itemBuilder: (context, index) {
                                  final actualIndex = startIndex + index;
                                  var currentChapter = chapterController
                                      .chapterList
                                      .firstWhere((element) =>
                                          element.id ==
                                          homeController.quizMatrixController
                                              .quizMatrixList
                                              .firstWhere(
                                                (element) =>
                                                    element.id ==
                                                    examController.examList
                                                        .firstWhere((p0) =>
                                                            p0.id ==
                                                            homeController
                                                                .recentResults[
                                                                    actualIndex]
                                                                .examId)
                                                        .quizMatrixId,
                                              )
                                              .chapterId);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: kMinPadding / 5),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () {
                                        examController.chosenExam.value =
                                            examController.examList.firstWhere(
                                                (p0) =>
                                                    p0.id ==
                                                    homeController
                                                        .recentResults[
                                                            actualIndex]
                                                        .examId);
                                        Get.toNamed(Routes.reviewExamScreen);
                                      },
                                      child: Stack(
                                        fit: StackFit.values.first,
                                        children: [
                                          Container(
                                            width: screenWidth -
                                                kDefaultPadding * 2,
                                            constraints: const BoxConstraints(
                                              minHeight: 60,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white
                                                    .withOpacity(0.8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        currentChapter
                                                                    .mathTypeId ==
                                                                1
                                                            ? 'assets/images/algebra_icon.png'
                                                            : currentChapter
                                                                        .mathTypeId ==
                                                                    2
                                                                ? 'assets/images/geometry_icon.png'
                                                                : 'assets/images/mixtype_icon.png',
                                                        width: 35,
                                                      ),
                                                      const SizedBox(
                                                        height: kMinPadding / 8,
                                                      ),
                                                      AutoSizeText(
                                                        minFontSize: 8,
                                                        gradeController
                                                            .gradeList
                                                            .firstWhere((element) =>
                                                                element.id ==
                                                                chapterController.chapterList
                                                                    .firstWhere((element) =>
                                                                        element.id ==
                                                                        homeController.quizMatrixController.quizMatrixList
                                                                            .firstWhere(
                                                                              (element) => element.id == examController.examList.firstWhere((p0) => p0.id == homeController.recentResults[actualIndex].examId).quizMatrixId,
                                                                            )
                                                                            .chapterId)
                                                                    .gradeId)
                                                            .name,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ColorPalette
                                                                .primaryColor),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          currentChapter.name,
                                                          style: const TextStyle(
                                                              color: ColorPalette
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          examController
                                                              .examList
                                                              .firstWhere((p0) =>
                                                                  p0.id ==
                                                                  homeController
                                                                      .recentResults[
                                                                          actualIndex]
                                                                      .examId)
                                                              .name!,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  'assets/images/num_of_quiz_icon.png',
                                                                  width: 15,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  '${homeController.recentResults[actualIndex].correctAnswers}/${homeController.recentResults[actualIndex].totalQuiz} câu',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              height: 30,
                                              width: 110,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                          topLeft:
                                                              Radius.circular(
                                                                  15)),
                                                  color: ColorPalette
                                                      .primaryColor),
                                              child: Center(
                                                child: Text(
                                                  'Điểm: ${scoreFormatter(homeController.recentResults[actualIndex].score!).toString()}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                          // Pagination buttons
                          homeController.recentResults.isEmpty
                              ? const Center(
                                  child: Text('Bạn chưa làm bài thi nào'),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      (homeController.recentResults.length /
                                              itemsPerPage)
                                          .ceil(),
                                      (pageIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            currentPage.value = pageIndex;
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              color: currentPage.value ==
                                                      pageIndex
                                                  ? ColorPalette.primaryColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                (pageIndex + 1).toString(),
                                                style: TextStyle(
                                                  color: currentPage.value !=
                                                          pageIndex
                                                      ? ColorPalette
                                                          .primaryColor
                                                      : Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}

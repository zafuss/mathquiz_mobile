import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/features/home/getx/home_controller.dart';
import 'package:mathquiz_mobile/helpers/score_formatter.dart';
import 'package:mathquiz_mobile/widgets/custom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double insideContainerMaxWidth = screenWidth - kDefaultPadding * 2 - 70;
    final homeController = Get.put(HomeController());
    final customDrawerController = CustomDrawerController();
    final examController = Get.put(ExamController());
    final chapterController = Get.put(ChapterController());
    return Scaffold(
        key: customDrawerController.scaffoldKey,
        // appBar: CustomAppBar(
        //   drawerController: customDrawerController,
        // ),
        drawer: CustomDrawer(
          controller: customDrawerController,
        ),
        body: Obx(() => Column(
              children: [
                CustomAppBarContainer(drawerController: customDrawerController),
                !homeController.isLoading.value &&
                        !chapterController.isLoading.value &&
                        !examController.isLoading.value
                    ? Flexible(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await _handleOnRefresh(examController,
                                homeController, chapterController);
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () {
                                    if (examController.isLoading.value) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (homeController
                                        .recentResults.isEmpty) {
                                      return const SizedBox();
                                    } else {
                                      return _buildRecentExams(
                                          homeController, examController);
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                _buildNewQuizMatrix(
                                  context,
                                  examController,
                                  homeController,
                                  chapterController,
                                  homeController.quizMatrixController,
                                  insideContainerMaxWidth,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ],
            )));
  }

  Widget _buildNewQuizMatrix(
    BuildContext context,
    ExamController examController,
    HomeController homeController,
    ChapterController chapterController,
    QuizMatrixController quizMatrixController,
    double insideContainerMaxWidth,
  ) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                top: kMinPadding / 2,
                bottom: kMinPadding / 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đề mới cập nhật',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: 6,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var chapterList = quizMatrixController
                  .getRecentChaptersInfo(chapterController.chapterList);
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kMinPadding / 3),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    homeController.quizMatrixController.chosenQuizMatrix.value =
                        homeController
                            .quizMatrixController.quizMatrixList[index];
                    examController.tempNumOfQuiz.value = homeController
                        .quizMatrixController
                        .chosenQuizMatrix
                        .value!
                        .numOfQuiz!;
                    examController.tempDuration.value = homeController
                        .quizMatrixController
                        .chosenQuizMatrix
                        .value!
                        .defaultDuration!;
                    await examController.fetchNumOfUsed(homeController
                        .quizMatrixController.chosenQuizMatrix.value!.id);
                    await examController.fetchRanking(homeController
                        .quizMatrixController.quizMatrixList[index].chapterId!);
                    Get.toNamed(Routes.examStartScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMinPadding, vertical: kMinPadding / 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                chapterList[index].mathType == 1
                                    ? 'assets/images/algebra_icon.png'
                                    : chapterList[index].mathType == 2
                                        ? 'assets/images/geometry_icon.png'
                                        : 'assets/images/mixtype_icon.png',
                                width: 45,
                              ),
                              const SizedBox(
                                  width:
                                      kMinPadding), // thêm khoảng cách giữa ảnh và văn bản
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${chapterList[index].chapterName}: ',
                                            style: const TextStyle(
                                                fontWeight:
                                                    FontWeight.bold), // In đậm
                                          ),
                                          TextSpan(
                                            text: chapterList[index]
                                                .quizMatrixName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight
                                                    .normal), // Ghi thường
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/grade_icon.png',
                                              width: 12,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              chapterList[index].grade <= 12
                                                  ? 'Lớp ${chapterList[index].grade}'
                                                  : 'Đại học',
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 13),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/num_of_quiz_icon.png',
                                              width: 12,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '${chapterList[index].numOfQuiz} câu',
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 13),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/time_icon.png',
                                              width: 12,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '${chapterList[index].duration} phút',
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: kMinPadding,
          )
        ],
      ),
    );
  }

  Column _buildRecentExams(
      HomeController homeController, ExamController examController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: Colors.white.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Đã làm gần đây',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  child: const Text(
                    'Xem tất cả',
                    style: TextStyle(
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () => Get.toNamed(Routes.examHistoryScreen),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 105,
          width: double.infinity,
          color: Colors.white.withOpacity(0.8),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: homeController.recentResults.length > 5
                ? 5
                : homeController.recentResults.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              var element = homeController.recentResults[index];
              return Row(
                children: [
                  index == 0
                      ? const SizedBox(
                          width: kDefaultPadding,
                        )
                      : const SizedBox(),
                  GestureDetector(
                    onTap: () {
                      examController.chosenExam.value = examController.examList
                          .firstWhere((p0) => p0.id == element.examId);
                      Get.toNamed(Routes.reviewExamScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 17),
                      child: Container(
                        width: 138,
                        decoration: BoxDecoration(
                          color: ColorPalette.backgroundColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                examController.examList
                                    .firstWhere(
                                        (exam) => element.examId == exam.id)
                                    .name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: ColorPalette.primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  const TextSpan(
                                    text: "Số câu đúng: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${element.correctAnswers}/${element.totalQuiz}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ColorPalette.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ]),
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  const TextSpan(
                                    text: "Điểm: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: scoreFormatter(element.score!)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ColorPalette.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  index == 4 && homeController.recentResults.length > 5
                      ? Padding(
                          padding: const EdgeInsets.only(right: kMinPadding),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.examHistoryScreen),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                  color: ColorPalette.backgroundColor,
                                  shape: BoxShape.circle),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorPalette.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _handleOnRefresh(
      ExamController examController,
      HomeController homeController,
      ChapterController chapterController) async {
    await chapterController.fetchChapters();
    await homeController.quizMatrixController.fetchQuizMatrices();
    await examController.fetchExams();
    await homeController.fetchRecentExam();
    Future.delayed(const Duration(seconds: 2));
  }
}

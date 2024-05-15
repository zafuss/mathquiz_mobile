import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/features/home/getx/home_controller.dart';
import 'package:mathquiz_mobile/widgets/custom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double insideContainerMaxWidth =
        screenWidth / 2 - (kDefaultPadding) - 17 / 2 - 30 * 2;
    final homeController = Get.put(HomeController());
    final customDrawerController = CustomDrawerController();
    final examController = Get.put(ExamController());
    final chapterController = Get.put(ChapterController());
    return Scaffold(
        key: customDrawerController.scaffoldKey,
        appBar: CustomAppBar(
          drawerController: customDrawerController,
        ),
        drawer: CustomDrawer(
          controller: customDrawerController,
        ),
        body: Obx(
          () => !homeController.isLoading.value &&
                  !chapterController.isLoading.value &&
                  !examController.isLoading.value
              ? RefreshIndicator(
                  onRefresh: () async {
                    await _handleOnRefresh(
                        examController, homeController, chapterController);
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
                            } else if (homeController.recentResults.isEmpty) {
                              return const SizedBox();
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: kDefaultPadding,
                                        top: kMinPadding / 2,
                                        bottom: kMinPadding / 3),
                                    child: Text(
                                      'Đề bạn đã làm gần đây',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    height: 105,
                                    width: double.infinity,
                                    color: Colors.white.withOpacity(0.8),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        const SizedBox(
                                            width:
                                                kDefaultPadding), // SizedBox được thêm vào đầu danh sách
                                        ...homeController.recentResults.map(
                                          (element) => GestureDetector(
                                            onTap: () {
                                              examController.chosenExam.value =
                                                  examController.examList
                                                      .firstWhere((p0) =>
                                                          p0.id ==
                                                          element.examId);
                                              Get.toNamed(
                                                  Routes.reviewExamScreen);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15,
                                                  bottom: 15,
                                                  right: 17),
                                              child: Container(
                                                width: 138,
                                                decoration: BoxDecoration(
                                                  color: ColorPalette
                                                      .backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        examController.examList
                                                            .firstWhere((exam) =>
                                                                element
                                                                    .examId ==
                                                                exam.id)
                                                            .name!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: ColorPalette
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text.rich(
                                                        TextSpan(children: [
                                                          const TextSpan(
                                                            text:
                                                                "Số câu đúng: ",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '${element.correctAnswers}/${element.totalQuiz}',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: ColorPalette
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
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
                                                            text:
                                                                '${element.score}',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: ColorPalette
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: kDefaultPadding,
                              top: kMinPadding / 2,
                              bottom: kMinPadding / 3),
                          child: Text(
                            'Đề mới cập nhật',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 17,
                              mainAxisSpacing: 17,
                              childAspectRatio: 1.8,
                              children: List.generate(
                                6,
                                (index) => GestureDetector(
                                  onTap: () {
                                    examController.fetchNumOfUsed(homeController
                                        .quizMatrixController
                                        .quizMatrixList[index]
                                        .id);
                                    homeController.quizMatrixController
                                            .chosenQuizMatrix.value =
                                        homeController.quizMatrixController
                                            .quizMatrixList[index];
                                    Get.toNamed(Routes.examStartScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kMinPadding / 3),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/algebra_icon.png',
                                                  width: 30,
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                AutoSizeText(
                                                  minFontSize: 8,
                                                  maxLines: 1,
                                                  chapterController.chapterList
                                                              .firstWhere((element) =>
                                                                  element.id ==
                                                                  homeController
                                                                      .quizMatrixController
                                                                      .quizMatrixList[
                                                                          index]
                                                                      .chapterId!)
                                                              .gradeId <=
                                                          12
                                                      ? 'Lớp ${chapterController.chapterList.firstWhere((element) => element.id == homeController.quizMatrixController.quizMatrixList[index].chapterId!).gradeId.toString()}'
                                                      : "Đại học",
                                                  style: const TextStyle(
                                                      color: ColorPalette
                                                          .primaryColor,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: kMinPadding / 3,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        insideContainerMaxWidth),
                                                child: AutoSizeText(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  chapterController.chapterList
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          homeController
                                                              .quizMatrixController
                                                              .quizMatrixList[
                                                                  index]
                                                              .chapterId!)
                                                      .name,
                                                  style: const TextStyle(
                                                    color: ColorPalette
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      insideContainerMaxWidth, // Đặt chiều rộng tối đa cho container
                                                ),
                                                child: AutoSizeText(
                                                  homeController
                                                      .quizMatrixController
                                                      .quizMatrixList[index]
                                                      .name!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  Future<void> _handleOnRefresh(
      ExamController examController,
      HomeController homeController,
      ChapterController chapterController) async {
    await examController.fetchExams();
    await homeController.fetchRecentExam();
    await chapterController.fetchChapters();
    await homeController.quizMatrixController.fetchQuizMatrices();
    Future.delayed(const Duration(seconds: 2));
  }
}

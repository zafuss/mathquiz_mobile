import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/result_controller.dart';
import 'package:mathquiz_mobile/helpers/classroom_datetime_formatter.dart';

class HomeworkListWidget extends StatelessWidget {
  const HomeworkListWidget(
      {super.key,
      required this.classroomController,
      required this.resultController,
      required this.chapterController,
      required this.quizMatrixController,
      required this.examController,
      this.itemCount});

  final ClassroomController classroomController;
  final ResultController resultController;
  final ChapterController chapterController;
  final QuizMatrixController quizMatrixController;
  final ExamController examController;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        classroomController.homeworkList.isEmpty
            ? const SizedBox()
            : classroomController.isTeacher.value
                ? Padding(
                    padding: const EdgeInsets.only(top: kMinPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.6)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kMinPadding / 2),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Bài tập đã giao',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                InkWell(
                                  child: const Text(
                                    'Xem tất cả',
                                    style: TextStyle(
                                        color: ColorPalette.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onTap: () {
                                    Get.toNamed(
                                        Routes.classroomHomeworkListScreen);
                                  },
                                )
                              ],
                            ),
                            const SizedBox(
                              height: kMinPadding / 2,
                            ),
                            classroomController.homeworkList.isEmpty
                                ? const Text('Bạn chưa giao bài tập nào')
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(0),
                                    itemCount: itemCount ??
                                        classroomController.homeworkList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: kMinPadding),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () async {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical:
                                                          kMinPadding / 2),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                          width:
                                                              kMinPadding), // thêm khoảng cách giữa ảnh và văn bản
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                style: DefaultTextStyle.of(
                                                                        context)
                                                                    .style
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black),
                                                                children: [
                                                                  TextSpan(
                                                                    text: classroomController
                                                                        .homeworkList[
                                                                            index]
                                                                        .title,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold), // In đậm
                                                                  ),
                                                                ],
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              softWrap: true,
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Có hiệu lực: ${classroomDateTimeFormatter(classroomController.homeworkList[index].handinDate)}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                                Text(
                                                                  'Hết hạn: ${classroomDateTimeFormatter(classroomController.homeworkList[index].expiredDate)}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                                Text(
                                                                  'Trạng thái: ${classroomController.homeworkList[index].status == 1 ? 'Đã giao' : 'Đã xoá'}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                                kMinPadding /
                                                                    2),
                                                        child: Column(
                                                          children: [
                                                            TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        ColorPalette
                                                                            .backgroundColor),
                                                                onPressed:
                                                                    () async {
                                                                  Get.toNamed(Routes
                                                                      .classroomHomeworkBestResultsScreen);
                                                                  classroomController
                                                                      .chosenHomework
                                                                      .value = classroomController
                                                                          .homeworkList[
                                                                      index];
                                                                  await classroomController
                                                                      .fetchResultList();
                                                                  await classroomController
                                                                      .fetchBestResultList();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Thống kê',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14),
                                                                )),
                                                            TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        ColorPalette
                                                                            .backgroundColor),
                                                                onPressed:
                                                                    () async {
                                                                  Get.toNamed(Routes
                                                                      .classroomEditHomeworkScreen);
                                                                  classroomController
                                                                      .chosenHomework
                                                                      .value = classroomController
                                                                          .homeworkList[
                                                                      index];
                                                                  await classroomController
                                                                      .fetchResultList();
                                                                  await classroomController
                                                                      .fetchBestResultList();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Sửa',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14),
                                                                )),
                                                          ],
                                                        ),
                                                      )
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
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: kMinPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.6)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kMinPadding / 2),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Bài tập được giao',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                classroomController
                                        .availableHomeworkList.isEmpty
                                    ? const SizedBox()
                                    : InkWell(
                                        child: const Text(
                                          'Xem tất cả',
                                          style: TextStyle(
                                              color: ColorPalette.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        onTap: () {
                                          Get.toNamed(Routes
                                              .classroomHomeworkListScreen);
                                        },
                                      )
                              ],
                            ),
                            const SizedBox(
                              height: kMinPadding / 2,
                            ),
                            if (classroomController
                                .availableHomeworkList.isEmpty)
                              const Text('Bạn chưa có bài tập nào')
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0),
                                itemCount: classroomController
                                    .availableHomeworkList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var isExpired = DateTime.now().compareTo(
                                      classroomController
                                          .availableHomeworkList[index]
                                          .expiredDate);
                                  int remainingAttempt =
                                      resultController.homeworkRemainingAttempt(
                                          classroomController
                                              .availableHomeworkList[index]);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: kMinPadding),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () async {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: kMinPadding / 2),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                      width:
                                                          kMinPadding), // thêm khoảng cách giữa ảnh và văn bản
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RichText(
                                                                text: TextSpan(
                                                                  style: DefaultTextStyle.of(
                                                                          context)
                                                                      .style
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.black),
                                                                  children: [
                                                                    TextSpan(
                                                                      text: classroomController
                                                                          .availableHomeworkList[
                                                                              index]
                                                                          .title,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold), // In đậm
                                                                    ),
                                                                  ],
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                softWrap: true,
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Có hiệu lực: ${classroomDateTimeFormatter(classroomController.availableHomeworkList[index].handinDate)}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                  Text(
                                                                    'Hết hạn: ${classroomDateTimeFormatter(classroomController.availableHomeworkList[index].expiredDate)}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                                  kMinPadding /
                                                                      2),
                                                          child: Column(
                                                            children: [
                                                              TextButton(
                                                                  style: TextButton.styleFrom(
                                                                      backgroundColor:
                                                                          ColorPalette
                                                                              .backgroundColor),
                                                                  onPressed:
                                                                      () async {
                                                                    if (remainingAttempt >
                                                                            0 &&
                                                                        isExpired <
                                                                            1) {
                                                                      classroomController
                                                                          .chosenHomework
                                                                          .value = classroomController
                                                                              .availableHomeworkList[
                                                                          index];
                                                                      chapterController.chosenChapter.value = chapterController.chapterList.firstWhere((e) =>
                                                                          e.id ==
                                                                          classroomController
                                                                              .availableHomeworkList[index]
                                                                              .quizMatrix!
                                                                              .chapterId);
                                                                      quizMatrixController
                                                                              .chosenQuizMatrix
                                                                              .value =
                                                                          classroomController
                                                                              .availableHomeworkList[index]
                                                                              .quizMatrix;
                                                                      await examController
                                                                          .fetchExams();
                                                                      await examController.fetchExamByQuizMatrixId(quizMatrixController
                                                                          .chosenQuizMatrix
                                                                          .value!
                                                                          .id);
                                                                      examController.tempNumOfQuiz.value = quizMatrixController
                                                                          .chosenQuizMatrix
                                                                          .value!
                                                                          .numOfQuiz!;
                                                                      examController.tempDuration.value = quizMatrixController
                                                                          .chosenQuizMatrix
                                                                          .value!
                                                                          .defaultDuration!;
                                                                      await examController.fetchRanking(chapterController
                                                                          .chosenChapter
                                                                          .value!
                                                                          .id);
                                                                      Get.toNamed(
                                                                          Routes
                                                                              .classroomExamStartScreen);
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    isExpired ==
                                                                            1
                                                                        ? 'Đã hết hạn'
                                                                        : remainingAttempt >
                                                                                0
                                                                            ? 'Làm ngay'
                                                                            : 'Hết lượt',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            14),
                                                                  )),
                                                              remainingAttempt >
                                                                      0
                                                                  ? Text(
                                                                      'Còn $remainingAttempt lượt',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black54,
                                                                          fontSize:
                                                                              13),
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
      ],
    );
  }
}

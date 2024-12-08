import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/exam_detail_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/quiz_controller.dart';
import 'package:mathquiz_mobile/screens/screens.dart';

class ClassroomExamStartScreen extends StatelessWidget {
  const ClassroomExamStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final quizMatrixController = Get.put(QuizMatrixController());
    final examController = Get.put(ExamController());
    final examDetailController = Get.put(ExamDetailController());
    final quizController = Get.put(QuizController());
    final classroomController = Get.find<ClassroomController>();

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          Obx(
            () => quizMatrixController.isLoading.value ||
                    examController.isLoading.value ||
                    examDetailController.isLoading.value ||
                    quizController.isLoading.value ||
                    classroomController.isLoading.value
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
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 100,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Lớp: ',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    ColorPalette.primaryColor),
                                            children: [
                                          TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              text: classroomController
                                                  .chosenHomework
                                                  .value!
                                                  .classroom
                                                  .name!)
                                        ])),
                                    const SizedBox(
                                      height: kMinPadding / 3,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Bài tập: ',
                                            style: const TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    ColorPalette.primaryColor),
                                            children: [
                                          TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              text:
                                                  '${classroomController.chosenHomework.value!.title}')
                                        ])),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/num_of_quiz_icon.png',
                                          width: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              '${examController.tempNumOfQuiz.value} câu'),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: kMinPadding,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/time_icon.png',
                                          width: 18,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              '${examController.tempDuration.value} phút'),
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: kDefaultPadding),
                                // _buildExamIntroduction(),

                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          defaultBorderRadius),
                                      color: Colors.white.withOpacity(0.6)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(kDefaultPadding),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: const TextSpan(
                                                text: 'Hướng dẫn',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorPalette
                                                        .primaryColor),
                                                children: [
                                              TextSpan(
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  text: ' làm bài trắc nghiệm')
                                            ])),
                                        const SizedBox(height: kMinPadding),
                                        _buildInstructionRow(
                                            'assets/images/choose_icon.png',
                                            "Chọn câu trả lời ",
                                            "đúng"),
                                        _buildInstructionRow(
                                            'assets/images/marker_icon.png',
                                            "Đánh dấu câu cần ",
                                            "xem lại"),
                                        _buildInstructionRow(
                                            'assets/images/next_icon.png',
                                            "Chuyển qua câu ",
                                            "kế tiếp"),
                                        _buildInstructionRow(
                                            'assets/images/previous_icon.png',
                                            "Quay lại ",
                                            "câu trước"),
                                        const SizedBox(height: kMinPadding / 2),
                                        const Text(
                                          'Lưu ý:',
                                          style: TextStyle(
                                              color: ColorPalette.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        _buildNoticeRow(
                                          "Những câu ",
                                          "chưa chọn đáp án ",
                                          "sẽ được tính là ",
                                          "câu trả lời sai.",
                                        ),
                                        _buildNoticeRow(
                                          "Nếu bạn ",
                                          "thoát ra ",
                                          "trong quá trình làm bài thì kết quả ",
                                          "sẽ không được tính.",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Obx(
                                  () => ElevatedButton(
                                    onPressed: () async {
                                      await examController.addClassroomExam(
                                          classroomController
                                              .chosenHomework.value!);
                                      await quizController
                                          .fetchQuizsByQuizMatrixId(
                                              quizMatrixController
                                                  .chosenQuizMatrix.value!.id);
                                      await examDetailController.addExamDetails(
                                          examController.currentExamId.value,
                                          quizController.searchedQuizList);
                                      await examDetailController
                                          .fetchExamDetailsByExamId(
                                              examController
                                                  .currentExamId.value);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DoExamScreen(
                                              func: () => Get.toNamed(
                                                  Routes.classroomResultScreen),
                                            ),
                                          ));
                                    },
                                    child: quizMatrixController
                                                .isLoading.value ||
                                            examController.isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text('Bắt đầu làm bài'),
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
        ],
      ),
    );
  }

  void showExamIntroductionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hướng dẫn ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'làm bài',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kMinPadding / 2),
                _buildInstructionRow('assets/images/choose_icon.png',
                    "Chọn câu trả lời ", "đúng"),
                _buildInstructionRow('assets/images/marker_icon.png',
                    "Đánh dấu câu cần ", "xem lại"),
                _buildInstructionRow('assets/images/next_icon.png',
                    "Chuyển qua câu ", "kế tiếp"),
                _buildInstructionRow('assets/images/previous_icon.png',
                    "Quay lại ", "câu trước"),
                const SizedBox(height: kMinPadding / 2),
                const Text(
                  'Lưu ý:',
                  style: TextStyle(
                      color: ColorPalette.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                _buildNoticeRow(
                  "Những câu ",
                  "chưa chọn đáp án ",
                  "sẽ được tính là ",
                  "câu trả lời sai.",
                ),
                _buildNoticeRow(
                  "Nếu bạn ",
                  "thoát ra ",
                  "trong quá trình làm bài thì kết quả ",
                  "sẽ không được tính.",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInstructionRow(String imagePath, String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 20,
          ),
          const SizedBox(width: 5),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: text1,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: text2,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeRow(
      String part1, String part2, String part3, String part4) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• '),
        Expanded(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: part1,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: part2,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: part3,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: part4,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  void _showCustomizeExamDialog(
      BuildContext context,
      QuizMatrixController quizMatrixController,
      ExamController examController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () {
            int maxNumOfQuiz =
                quizMatrixController.chosenQuizMatrix.value!.numOfQuiz!;
            List<int> durationOptions =
                List.generate((120 ~/ 10) + 1, (index) => index * 10);
            List<int> numOfQuizOptions =
                List.generate(maxNumOfQuiz, (index) => index + 1).toList();

            durationOptions.removeAt(0);
            // Ensure the current tempDuration value is valid
            if (!durationOptions.contains(examController.tempDuration.value)) {
              examController.tempDuration.value = durationOptions.first;
            }

            return AlertDialog(
              surfaceTintColor: Colors.white,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tuỳ chỉnh ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'đề thi',
                    style: TextStyle(
                        color: ColorPalette.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Số câu hỏi"),
                      DropdownButton<int>(
                        value: examController.tempNumOfQuiz.value,
                        items: numOfQuizOptions
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text('$value câu'),
                                ))
                            .toList(),
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            examController.tempNumOfQuiz.value = newValue;
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Thời gian (phút)"),
                      DropdownButton<int>(
                        value: examController.tempDuration.value,
                        items: durationOptions
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text('$value phút'),
                                ))
                            .toList(),
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            examController.tempDuration.value = newValue;
                          }
                        },
                      ),
                    ],
                  ),
                ],
              )),
              actions: [
                TextButton(
                    onPressed: () {
                      examController.tempDuration.value = quizMatrixController
                          .chosenQuizMatrix.value!.defaultDuration!;
                      examController.tempNumOfQuiz.value = quizMatrixController
                          .chosenQuizMatrix.value!.numOfQuiz!;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Huỷ")),
                SizedBox(
                  height: 35,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Tuỳ chỉnh')),
                )
              ],
            );
          },
        );
      },
    );
  }
}

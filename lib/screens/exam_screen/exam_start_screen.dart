import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/dtos/ranking_dto.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/exam_detail_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/quiz_controller.dart';
import '../../widgets/ranking_widget.dart';

class ExamStartScreen extends StatelessWidget {
  const ExamStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final quizmatrixController = Get.put(QuizMatrixController());
    final examController = Get.put(ExamController());
    final examDetailController = Get.put(ExamDetailController());
    final quizController = Get.put(QuizController());

    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
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
            () => quizmatrixController.isLoading.value ||
                    examController.isLoading.value ||
                    examDetailController.isLoading.value ||
                    quizController.isLoading.value
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
                                    const Text(
                                      'Đề thi',
                                      style: TextStyle(
                                          height: 1,
                                          fontSize: 30,
                                          color: ColorPalette.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    AutoSizeText(
                                      maxLines: 2,
                                      quizmatrixController
                                              .chosenQuizMatrix.value!.name ??
                                          'null',
                                      style: const TextStyle(
                                          height: 1.1,
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/num_of_client_icon.png',
                                          width: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              '${examController.numOfUsed} lượt thi'),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () =>
                                        showExamIntroductionDialog(context),
                                    child: const Text(
                                      'Xem hướng dẫn làm bài',
                                      style: TextStyle(
                                          color: ColorPalette.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(height: kDefaultPadding),
                                // _buildExamIntroduction(),

                                rankingWidget(
                                    examController.ranking as List<RankingDto>,
                                    3.5),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Obx(
                                () => ElevatedButton(
                                  onPressed: () async {
                                    await examController.addExam(
                                        quizmatrixController
                                            .chosenQuizMatrix.value!);
                                    await quizController
                                        .fetchQuizsByQuizMatrixId(
                                            quizmatrixController
                                                .chosenQuizMatrix.value!.id);
                                    await examDetailController.addExamDetails(
                                        examController.currentExamId.value,
                                        quizController.searchedQuizList);
                                    await examDetailController
                                        .fetchExamDetailsByExamId(
                                            examController.currentExamId.value);
                                    Get.toNamed(Routes.doExamScreen);
                                  },
                                  child: quizmatrixController.isLoading.value ||
                                          examController.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text('Bắt đầu làm bài'),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    _showCustomizeExamDialog(context,
                                        quizmatrixController, examController);
                                  },
                                  child: const Text('Tuỳ chỉnh đề thi')),
                            ],
                          )
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

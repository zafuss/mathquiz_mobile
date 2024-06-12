import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/exam_detail_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/quiz_controller.dart';

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
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Đề thi',
                                      style: TextStyle(
                                          height: 1,
                                          fontSize: 40,
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
                                          fontSize: 30,
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
                                const SizedBox(height: kDefaultPadding),
                                _buildExamIntroduction(),
                                const SizedBox(height: kDefaultPadding),
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

  Column _buildExamIntroduction() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(children: [
              TextSpan(
                text: "Hướng dẫn ",
                style: TextStyle(
                    fontSize: 18,
                    color: ColorPalette.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: "làm bài trắc nghiệm",
                style: TextStyle(
                    fontSize: 18,
                    color: ColorPalette.primaryColor,
                    fontWeight: FontWeight.w400),
              ),
            ]),
          ),
        ),
        const SizedBox(
          height: kMinPadding / 2,
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/choose_icon.png',
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(children: [
                  TextSpan(
                    text: "Chọn câu trả lời ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "đúng",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/marker_icon.png',
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(children: [
                  TextSpan(
                    text: "Đánh dấu câu cần ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "xem lại",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/next_icon.png',
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(children: [
                  TextSpan(
                    text: "Chuyển qua câu ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "kế tiếp",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/previous_icon.png',
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(children: [
                  TextSpan(
                    text: "Quay lại ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "câu trước",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: kMinPadding / 2,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lưu ý:',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• '),
                Expanded(
                  child: Text.rich(
                    maxLines: 3,
                    TextSpan(children: [
                      TextSpan(
                        text: "Những câu ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "chưa chọn đáp án ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: "sẽ được tính là ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "câu trả lời sai.",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• '),
                Expanded(
                  child: Text.rich(
                    maxLines: 3,
                    TextSpan(children: [
                      TextSpan(
                        text: "Nếu bạn ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "thoát ra ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: "trong quá trình làm bài thì kết quả ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "sẽ không được tính.",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ],
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
                        items: List.generate(
                            maxNumOfQuiz + 1,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text('$index câu'),
                                )),
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

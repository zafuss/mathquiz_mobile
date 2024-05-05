import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/do_exam_controller.dart';
import 'package:mathquiz_mobile/helpers/latex_helpers.dart';
import '../../config/demension_const.dart';

class DoExamScreen extends StatelessWidget {
  const DoExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final doExamController = Get.put(DoExamController());
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
                doExamController.stopTimer();
              },
            ),
          ),
          Obx(
            () => doExamController.isLoading.value
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Câu ${doExamController.currentQuizIndex.value + 1}/${doExamController.examDetailList.length}:',
                                  style: const TextStyle(
                                    color: ColorPalette.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorPalette
                                              .primaryColor, // Màu của viền
                                          width: 2, // Độ dày của viền
                                        ),
                                        shape: BoxShape.circle,
                                        color:
                                            Colors.white, // Màu của hình tròn
                                      ),
                                      child: Center(
                                          child: Text(_formatDuration(
                                              doExamController
                                                  .remainingTime.value))),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Flexible(
                              child: ListView(
                                children: [
                                  renderTextAndLaTeX(doExamController
                                      .currentQuiz.value!.statement!),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  Column(
                                    children: doExamController
                                        .currentQuizOptions
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              child: InkWell(
                                                onTap: () => doExamController
                                                    .handleChooseAnOption(e.id),
                                                hoverColor: ColorPalette
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                                child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth:
                                                                double.infinity,
                                                            minHeight: 58),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: e.id ==
                                                                doExamController
                                                                    .currentExamDetail
                                                                    .value!
                                                                    .selectedOption
                                                            ? ColorPalette
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.3)
                                                            : Colors.white
                                                                .withOpacity(
                                                                    0.8)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10.0),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(
                                                          children: [
                                                            e.id ==
                                                                    doExamController
                                                                        .currentExamDetail
                                                                        .value!
                                                                        .selectedOption
                                                                ? Image.asset(
                                                                    'assets/images/choose_icon.png',
                                                                    width: 20,
                                                                  )
                                                                : Image.asset(
                                                                    'assets/images/unchoose_icon.png',
                                                                    width: 20,
                                                                  ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  renderTextAndLaTeX(
                                                                      e.option!),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  const SizedBox(
                                    height: kMinPadding / 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      doExamController.currentQuizIndex.value >
                                              0
                                          ? GestureDetector(
                                              onTap: () => doExamController
                                                  .handlePreviousQuiz(),
                                              child: Image.asset(
                                                'assets/images/previous_icon.png',
                                                width: 35,
                                              ))
                                          : const SizedBox(),
                                      Expanded(child: Container()),
                                      !doExamController.isLastQuiz.value
                                          ? GestureDetector(
                                              onTap: () => doExamController
                                                  .handleNextQuiz(),
                                              child: Image.asset(
                                                'assets/images/next_icon.png',
                                                width: 35,
                                              ))
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  doExamController.isLastQuiz.value
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            await doExamController
                                                .saveNewExamDetailList();
                                            Get.offNamed(Routes.resultScreen);
                                          },
                                          child: doExamController
                                                  .isGettingResult.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Text('Nộp bài'))
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigitMinutes}:${twoDigitSeconds}";
  }
}

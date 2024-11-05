import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                _showExitConfirmDialog(context, doExamController);
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
                                Row(
                                  children: [
                                    Text(
                                      'Câu ${doExamController.currentQuizIndex.value + 1}/${doExamController.examDetailList.length}:',
                                      style: const TextStyle(
                                        color: ColorPalette.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        doExamController.handleMarkedQuiz();
                                      },
                                      child: Image.asset(
                                          width: 17,
                                          doExamController.markedQuiz.contains(
                                                  doExamController
                                                      .currentQuizIndex.value)
                                              ? 'assets/images/marker_icon.png'
                                              : 'assets/images/unmarker_icon.png'),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorPalette
                                              .primaryColor, // Màu của viền
                                          width: 2, // Độ dày của viền
                                        ),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(kMinPadding),
                                        color:
                                            Colors.white, // Màu của hình tròn
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Center(
                                            child: AutoSizeText(
                                          _formatDuration(doExamController
                                              .remainingTime.value),
                                          maxLines: 1,
                                        )),
                                      ),
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
                                  doExamController.currentQuiz.value!.image !=
                                          null
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical:
                                                          kMinPadding / 2),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.white
                                                        .withOpacity(0.8)),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: kDefaultPadding,
                                                        right: kDefaultPadding,
                                                        top: kMinPadding,
                                                        bottom: kMinPadding),
                                                    child: renderImage(
                                                        doExamController),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: kMinPadding,
                                  ),
                                  Column(
                                    children: doExamController
                                        .currentQuizOptions
                                        .asMap()
                                        .map((index, e) => MapEntry(
                                              index,
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: InkWell(
                                                  onTap: () => doExamController
                                                      .handleChooseAnOption(
                                                          e.id),
                                                  hoverColor: ColorPalette
                                                      .primaryColor
                                                      .withOpacity(0.1),
                                                  child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: double
                                                                  .infinity,
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
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    10.0),
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
                                                              Text(
                                                                '${String.fromCharCode(65 + index)}. ',
                                                              ),
                                                              Flexible(
                                                                child: Column(
                                                                  children: [
                                                                    e.quizOptionImage !=
                                                                            null
                                                                        ? Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: kMinPadding / 2),
                                                                              child: SvgPicture.network(
                                                                                width: 125,
                                                                                e.quizOptionImage!,
                                                                                placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : const SizedBox(),
                                                                    renderTextAndLaTeX(
                                                                        e.option!),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ))
                                        .values
                                        .toList(),
                                  ),
                                  const SizedBox(
                                    height: kMinPadding / 2,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kMinPadding / 4,
                                  horizontal: kDefaultPadding / 1.5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(kMinPadding)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          doExamController.isFirstQuiz.value
                                              ? GestureDetector(
                                                  onTap: () => doExamController
                                                      .handlePreviousQuiz(),
                                                  child: Image.asset(
                                                    'assets/images/previous_icon.png',
                                                    width: 40,
                                                  ))
                                              : const SizedBox(),
                                          SizedBox(
                                            width: kMinPadding / 2,
                                          ),
                                          !doExamController.isLastQuiz.value
                                              ? GestureDetector(
                                                  onTap: () => doExamController
                                                      .handleNextQuiz(),
                                                  child: Image.asset(
                                                    'assets/images/next_icon.png',
                                                    width: 40,
                                                  ))
                                              : Expanded(
                                                  child: SizedBox(
                                                    height: 40,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          if (await doExamController
                                                              .handleSubmitExam()) {
                                                            Get.offNamed(Routes
                                                                .resultScreen);
                                                          } else {
                                                            _submitFailedDialog(
                                                                context,
                                                                doExamController);
                                                          }
                                                        },
                                                        child: doExamController
                                                                .isGettingResult
                                                                .value
                                                            ? const Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            : const Text(
                                                                'Nộp bài')),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmDialog(
      BuildContext context, DoExamController doExamController) {
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
                'Thoát khỏi ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'bài thi',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content:
              const Text('Bạn có chắc chắn muốn thoát khỏi bài thi không?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                doExamController.stopTimer();
                Get.back(); // Close the dialog
                Navigator.of(context).pop(); // Close the screen
              },
              child: const Text(
                'Có',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _submitFailedDialog(
      BuildContext context, DoExamController doExamController) {
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
                'Vẫn nộp ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'bài thi',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: const Text(
              'Có một số câu chưa chọn đáp án, bạn vẫn muốn nộp bài chứ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () async {
                await doExamController.forceSubmitExam();
                Get.offAndToNamed(Routes.resultScreen);
              },
              child: const Text(
                'Có',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget renderImage(DoExamController doExamController) {
    try {
      return SvgPicture.network(
        doExamController.currentQuiz.value!.image!,
        placeholderBuilder: (BuildContext context) =>
            const CircularProgressIndicator(),
      );
    } catch (e) {
      var image = Image.network(
        doExamController.currentQuiz.value!.image!,
        fit: BoxFit.fill,
      );

      return image;
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigitHours == "00") {
      return "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}

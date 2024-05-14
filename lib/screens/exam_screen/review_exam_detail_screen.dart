import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/review_exam/getx/review_exam_controller.dart';

import '../../config/color_const.dart';
import '../../config/demension_const.dart';
import '../../helpers/latex_helpers.dart';

class ReviewExamDetailScreen extends StatelessWidget {
  const ReviewExamDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewExamController = Get.find<ReviewExamController>();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
                if (reviewExamController.chosenExamDetail.length ==
                    reviewExamController.examDetailList.length) {
                  reviewExamController.chosenExamDetail.value = [];
                }
                reviewExamController.currentIndex.value = 0;
                // reviewExamController.currentCorrectOption.value = null;
                // reviewExamController.currentExamDetail.value = null;
              },
            ),
          ),
          Obx(
            () => SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        'Câu ${reviewExamController.examDetailList.indexWhere((element) => element.id == reviewExamController.currentExamDetail.value!.id) + 1}/${reviewExamController.examDetailList.length}:',
                        style: const TextStyle(
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      renderTextAndLaTeX(
                          reviewExamController.currentQuiz.value!.statement!),
                      reviewExamController.currentQuiz.value!.image != null
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kMinPadding / 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white.withOpacity(0.8)),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: kDefaultPadding,
                                            right: kDefaultPadding,
                                            top: kMinPadding,
                                            bottom: kMinPadding),
                                        child:
                                            renderImage(reviewExamController),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const Text(
                        'Bạn chọn',
                        style: TextStyle(color: ColorPalette.primaryColor),
                      ),
                      reviewExamController.chosenOption.value != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: reviewExamController
                                            .chosenOption.value!.isCorrect
                                        ? const Color.fromRGBO(
                                            109, 219, 42, 0.3)
                                        : const Color.fromRGBO(
                                            255, 49, 49, 0.3)),
                                child: Center(
                                    child: renderTextAndLaTeX(
                                        reviewExamController
                                            .chosenOption.value!.option!)),
                              ),
                            )
                          : const Text(
                              'Bạn đã không chọn đáp án',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 49, 49, 1)),
                            ),
                      const Text(
                        'Đáp án',
                        style: TextStyle(
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:
                                  ColorPalette.primaryColor.withOpacity(0.3)),
                          child: Center(
                              child: renderTextAndLaTeX(reviewExamController
                                  .currentCorrectOption.value!.option!)),
                        ),
                      ),
                      const Text(
                        'Giải thích',
                        style: TextStyle(color: ColorPalette.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      renderTextAndLaTeX(
                          reviewExamController.currentQuiz.value!.solution!),
                      const SizedBox(
                        height: kMinPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          reviewExamController.currentIndex.value > 0
                              ? GestureDetector(
                                  onTap: () =>
                                      reviewExamController.handlePreviousQuiz(),
                                  child: Image.asset(
                                    'assets/images/previous_icon.png',
                                    width: 35,
                                  ))
                              : const SizedBox(),
                          Expanded(child: Container()),
                          !reviewExamController.isLastQuiz.value
                              ? GestureDetector(
                                  onTap: () =>
                                      reviewExamController.handleNextQuiz(),
                                  child: Image.asset(
                                    'assets/images/next_icon.png',
                                    width: 35,
                                  ))
                              : const SizedBox(),
                        ],
                      ),
                      reviewExamController.currentQuiz.value!.imageSolution !=
                              null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: kDefaultPadding,
                                    right: kDefaultPadding,
                                    top: kMinPadding,
                                    bottom: kMinPadding),
                                child:
                                    renderImageSolution(reviewExamController),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderImage(ReviewExamController reviewExamController) {
    try {
      return SvgPicture.network(
        reviewExamController.currentQuiz.value!.image!,
        placeholderBuilder: (BuildContext context) =>
            const CircularProgressIndicator(),
      );
    } catch (e) {
      var image = Image.network(
        reviewExamController.currentQuiz.value!.image!,
        fit: BoxFit.fill,
      );

      return image;
    }
  }

  Widget renderImageSolution(ReviewExamController reviewExamController) {
    try {
      return SvgPicture.network(
        reviewExamController.currentQuiz.value!.imageSolution!,
        placeholderBuilder: (BuildContext context) =>
            const CircularProgressIndicator(),
      );
    } catch (e) {
      var image = Image.network(
        reviewExamController.currentQuiz.value!.imageSolution!,
        fit: BoxFit.fill,
      );

      return image;
    }
  }
}

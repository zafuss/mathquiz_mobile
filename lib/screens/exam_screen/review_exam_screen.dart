import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/review_exam/getx/review_exam_controller.dart';

class ReviewExamScreen extends StatelessWidget {
  const ReviewExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewExamController = Get.put(ReviewExamController());
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
            () => reviewExamController.isLoading.value
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: kDefaultPadding,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Xem lại',
                                      style: TextStyle(
                                          color: ColorPalette.primaryColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'bài thi',
                                      style: TextStyle(
                                          height: 1,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () async {
                                      reviewExamController
                                              .chosenExamDetail.value =
                                          reviewExamController.examDetailList;
                                      await reviewExamController
                                          .fetchCurrentQuiz();
                                      Get.toNamed(
                                          Routes.reviewExamDetailScreen);
                                    },
                                    child: const Text(
                                      'Xem lại toàn bộ bài thi',
                                      style: TextStyle(
                                          color: ColorPalette.primaryColor,
                                          fontSize: 14),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Chọn câu hỏi bạn muốn xem lại:',
                                    style: TextStyle(fontSize: 14)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 5,
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                        reviewExamController
                                            .examDetailList.length, (index) {
                                      var currentExamDetail =
                                          reviewExamController
                                              .examDetailList[index];
                                      var isCurrentQuizOptionCorrect =
                                          currentExamDetail.selectedOption == -1
                                              ? false
                                              : reviewExamController
                                                  .quizOptionController
                                                  .quizOptionList
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      currentExamDetail
                                                          .selectedOption)
                                                  .isCorrect;
                                      var isChosen = reviewExamController
                                          .chosenExamDetail
                                          .contains(currentExamDetail);
                                      return GestureDetector(
                                        onTap: () => !isChosen
                                            ? reviewExamController
                                                .chosenExamDetail
                                                .add(currentExamDetail)
                                            : reviewExamController
                                                .chosenExamDetail
                                                .remove(currentExamDetail),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: !isChosen
                                                        ? Colors.white
                                                        : ColorPalette
                                                            .primaryColor,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: ColorPalette
                                                            .primaryColor)),
                                                child: Center(
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                        color: isChosen
                                                            ? Colors.white
                                                            : ColorPalette
                                                                .primaryColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Image.asset(
                                                isCurrentQuizOptionCorrect
                                                    ? "assets/images/correct_answer.png"
                                                    : "assets/images/wrong_answer.png",
                                                width: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: reviewExamController
                                        .chosenExamDetail.isNotEmpty
                                    ? MaterialStateProperty.all<Color>(
                                        ColorPalette.primaryColor)
                                    : MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 209, 208, 208)
                                            .withOpacity(0.5)),
                              ),
                              onPressed: () async {
                                if (reviewExamController
                                    .chosenExamDetail.isNotEmpty) {
                                  await reviewExamController.fetchCurrentQuiz();
                                  Get.toNamed(Routes.reviewExamDetailScreen);
                                }
                              },
                              child:
                                  const Text('Xem lại những câu bạn đã chọn'))
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

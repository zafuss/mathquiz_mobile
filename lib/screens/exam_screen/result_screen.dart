import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/choose_exam/dtos/ranking_dto.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/do_exam_controller.dart';

import '../../helpers/score_formatter.dart';
import '../../widgets/ranking_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doExamController = Get.find<DoExamController>();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          doExamController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Kết quả',
                              style: TextStyle(
                                  height: 1,
                                  fontSize: 40,
                                  color: ColorPalette.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'bài thi',
                              style: TextStyle(
                                  height: 1,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600),
                            ),
                            const AutoSizeText(
                              'Chúc mừng bạn đã hoàn thành bài thi!',
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: kDefaultPadding / 2,
                            ),
                            Center(
                                child: Column(
                              children: [
                                const Text(
                                  'Bạn đạt được',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.all(kMinPadding / 2),
                                  child: Container(
                                    width: 106,
                                    height: 106,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white, // Màu của hình tròn
                                    ),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          scoreFormatter(doExamController
                                                  .result.value!.score!)
                                              .toString(),
                                          style: const TextStyle(
                                              height: 1,
                                              fontSize: 35,
                                              fontWeight: FontWeight.w600,
                                              color: ColorPalette.primaryColor),
                                        ),
                                        const Text('Điểm')
                                      ],
                                    )),
                                  ),
                                ),
                                Container(
                                  height: 34,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Số câu đúng:'),
                                        Text(
                                          '${doExamController.result.value!.correctAnswers}/${doExamController.result.value!.totalQuiz}',
                                          style: const TextStyle(
                                              color: ColorPalette.primaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                            const SizedBox(
                              height: kMinPadding / 2,
                            ),
                            rankingWidget(
                                doExamController.examController.ranking
                                    as List<RankingDto>,
                                5)
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => Get.offAllNamed(Routes.homeScreen),
                          child: const Text('Trở về màn hình chính')),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              doExamController.examDetailController
                                  .fetchExamDetails();
                              Get.toNamed(Routes.reviewExamScreen);
                            },
                            child: const Text('Xem lại bài thi')),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
